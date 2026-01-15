import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/feedback_constants.dart';
import '../../../../core/constants/game_constants.dart';
import '../../../../core/services/leaderboard_service.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/models/tap_feedback.dart';
import '../../domain/models/simulation_mode.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState()) {
    LoggerService.info('GameCubit initialized');
  }

  DateTime? _lastUpdateTime;
  bool _scoreSaved = false;
  final Random _random = Random();
  
  // Physics constants
  // Default gravity acceleration: 2000 px/s² (realistic for mobile game)
  static const double defaultGravity = 2000.0;
  
  // Default restitution coefficient: 0.85 (energy loss on bounce, between 0.7-0.85)
  // Higher values = less energy loss, ball bounces higher
  static const double defaultRestitution = 0.85;
  
  // Velocity threshold to stop bouncing (px/s)
  // When velocity is below this, ball stops bouncing to avoid infinite micro-bounces
  static const double minBounceVelocity = 50.0;
  
  // Minimum bounce velocity to ensure strong bounces even at low speeds
  static const double minBounceVelocityUpward = 400.0;
  
  // Maximum velocity limit to prevent unrealistic speeds (px/s)
  static const double maxVelocity = 1500.0;
  
  // Floor height from bottom of screen
  static const double floorHeight = GameConstants.floorHeight;
  
  bool _wasOnFloor = false;

  void startGame({SimulationMode? mode}) {
    LoggerService.info('Game started with mode: ${mode ?? state.simulationMode}');
    _wasOnFloor = false;
    _scoreSaved = false;
    _lastUpdateTime = DateTime.now();
    
    final simulationMode = mode ?? state.simulationMode;
    final gravity = _getGravityForMode(simulationMode);
    final bounceLevel = state.bounceLevel;
    
    emit(
      state.copyWith(
        isPlaying: true,
        isPaused: false,
        ballX: 0.5,
        ballY: 0.3,
        velocityX: 0.0,
        velocityY: 0.0,
        score: 0,
        justBouncedFromFloor: false,
        tapFeedbacks: const [],
        simulationMode: simulationMode,
        gravity: gravity,
        bounceLevel: bounceLevel,
      ),
    );
  }

  double _getGravityForMode(SimulationMode mode) {
    switch (mode) {
      case SimulationMode.classic:
        return defaultGravity;
      case SimulationMode.gravityLab:
        return state.gravity;
      case SimulationMode.chaosMode:
        return defaultGravity;
    }
  }

  void togglePause() {
    if (state.isPaused) {
      resumeGame();
    } else {
      pauseGame();
    }
  }

  void pauseGame() {
    if (state.isPaused || !state.isPlaying) return;
    LoggerService.info('Game paused');
    _lastUpdateTime = null;
    emit(state.copyWith(isPaused: true));
  }

  void resumeGame() {
    if (!state.isPaused || !state.isPlaying) return;
    LoggerService.info('Game resumed');
    _lastUpdateTime = DateTime.now();
    emit(state.copyWith(isPaused: false));
  }

  void restartGame() {
    LoggerService.info('Game restarted');
    startGame();
  }

  void stopGame() {
    LoggerService.info('Game stopped');
    _lastUpdateTime = null;
    
    if (!_scoreSaved && state.score > 0) {
      LeaderboardService.saveScore(state.score);
      _scoreSaved = true;
    }
    
    emit(state.copyWith(isPlaying: false, isPaused: false, tapFeedbacks: []));
  }

  void onTap(
    double tapX,
    double tapY,
    double screenWidth,
    double screenHeight,
  ) {
    if (!state.isPlaying || state.isPaused) return;

    final double ballScreenX = state.ballX * screenWidth;
    final double ballScreenY = state.ballY * screenHeight;

    final double dx = tapX - ballScreenX;
    final double dy = tapY - ballScreenY;
    final double distance = sqrt(dx * dx + dy * dy);

    if (distance < GameConstants.ballRadius * GameConstants.ballTapRadius) {
      LoggerService.debug('Ball tapped at distance: $distance');
      
      final double floorY = screenHeight - floorHeight;
      final double distanceFromFloor = (floorY - ballScreenY).abs();
      
      const double floorProximityMultiplier = 0.3;
      double baseTapImpulse = 600.0;
      double maxTapImpulse = 1000.0;
      const double horizontalImpulseRatio = 0.2;
      
      if (state.simulationMode == SimulationMode.chaosMode) {
        baseTapImpulse = 400.0 + _random.nextDouble() * 800.0;
        maxTapImpulse = baseTapImpulse + 400.0;
      }
      
      final double floorProximity = (1.0 - (distanceFromFloor / (screenHeight * floorProximityMultiplier)).clamp(0.0, 1.0));
      double tapImpulse = baseTapImpulse + (floorProximity * (maxTapImpulse - baseTapImpulse));
      
      if (state.simulationMode == SimulationMode.chaosMode) {
        tapImpulse += (_random.nextDouble() - 0.5) * 300.0;
      }
      
      if (distance > 0) {
        final double normalizedX = -dx / distance;
        
        double impulseX = normalizedX * tapImpulse * horizontalImpulseRatio;
        double impulseY = -tapImpulse;
        
        if (state.simulationMode == SimulationMode.chaosMode) {
          impulseX += (_random.nextDouble() - 0.5) * 200.0;
          impulseY += (_random.nextDouble() - 0.5) * 100.0;
        }

        final feedbackText = FeedbackConstants.feedbackTexts[
          _random.nextInt(FeedbackConstants.feedbackTexts.length)
        ];
        
        final newFeedback = TapFeedback(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: feedbackText,
          x: tapX - FeedbackConstants.textOffsetX / 2,
          y: tapY - FeedbackConstants.textOffsetY,
          timestamp: DateTime.now(),
        );

        emit(
          state.copyWith(
            velocityX: state.velocityX + impulseX,
            velocityY: state.velocityY + impulseY,
            score: state.score + 1,
            tapFeedbacks: [...state.tapFeedbacks, newFeedback],
          ),
        );
        
        LoggerService.debug('Ball tapped, score: ${state.score + 1}');
      }
    }
  }

  /// Updates physics using delta time for frame-rate independent simulation
  /// Uses Euler integration: position += velocity * dt, velocity += acceleration * dt
  void updatePhysics(double screenWidth, double screenHeight) {
    if (!state.isPlaying || state.isPaused) return;

    // Calculate delta time in seconds
    final now = DateTime.now();
    if (_lastUpdateTime == null) {
      _lastUpdateTime = now;
      return;
    }
    
    final deltaTimeSeconds = (now.difference(_lastUpdateTime!).inMicroseconds / 1000000.0);
    _lastUpdateTime = now;
    
    const double maxDeltaTime = 0.1;
    final double dt = deltaTimeSeconds.clamp(0.0, maxDeltaTime);

    final double floorY = screenHeight - floorHeight;
    final double minX = GameConstants.ballRadius;
    final double maxX = screenWidth - GameConstants.ballRadius;
    final double minY = GameConstants.ballRadius;
    final double maxY = floorY - GameConstants.ballRadius;

    // Convert relative positions (0.0-1.0) to absolute pixel positions
    double ballX = state.ballX * screenWidth;
    double ballY = state.ballY * screenHeight;
    double velocityX = state.velocityX;
    double velocityY = state.velocityY;

    // Apply gravity acceleration: v = v0 + a * t
    final currentGravity = state.gravity;
    velocityY += currentGravity * dt;

    // Update position using velocity: x = x0 + v * t
    ballX += velocityX * dt;
    ballY += velocityY * dt;

    bool bouncedFromFloor = false;
    int newScore = state.score;

    // Apply friction if enabled
    if (state.frictionEnabled && !_wasOnFloor) {
      const double frictionCoefficient = 0.98;
      velocityX *= frictionCoefficient;
    }
    
    // Collision detection and response for walls (X-axis)
    final restitution = state.bounceLevel;
    if (ballX < minX) {
      ballX = minX;
      velocityX = -velocityX * restitution;
      LoggerService.debug('Ball bounced from left wall');
    } else if (ballX > maxX) {
      ballX = maxX;
      velocityX = -velocityX * restitution;
      LoggerService.debug('Ball bounced from right wall');
    }

    // Collision detection and response for top wall
    if (ballY < minY) {
      ballY = minY;
      velocityY = -velocityY * restitution;
      LoggerService.debug('Ball bounced from top wall');
    }

    // Collision detection and response for floor (bottom)
    if (ballY > maxY) {
      ballY = maxY;
      
      // Only bounce if moving downward and velocity is above threshold
      if (velocityY > 0 && velocityY.abs() >= minBounceVelocity) {
        // Elastic collision with energy loss: v' = -v * restitution
        // Ensure minimum upward velocity for strong bounces
        final double bounceVelocity = (-velocityY * restitution).abs();
        velocityY = -bounceVelocity.clamp(minBounceVelocityUpward, maxVelocity);
        bouncedFromFloor = true;
        
        _wasOnFloor = true;
      } else {
        final double stoppedFriction = state.frictionEnabled ? 0.90 : 0.95;
        velocityY = 0;
        velocityX *= stoppedFriction;
        if (_wasOnFloor) {
          _wasOnFloor = false;
        }
      }
    } else {
      const double upwardVelocityThreshold = -10.0;
      if (_wasOnFloor && velocityY < upwardVelocityThreshold) {
        _wasOnFloor = false;
      }
    }

    // Limit maximum velocity to prevent unrealistic speeds
    velocityX = velocityX.clamp(-maxVelocity, maxVelocity);
    velocityY = velocityY.clamp(-maxVelocity, maxVelocity);

    // Convert back to relative coordinates (0.0 - 1.0) for state
    emit(
      state.copyWith(
        ballX: ballX / screenWidth,
        ballY: ballY / screenHeight,
        velocityX: velocityX,
        velocityY: velocityY,
        score: newScore,
        justBouncedFromFloor: bouncedFromFloor,
      ),
    );
  }

  void removeTapFeedback(String feedbackId) {
    final updatedFeedbacks = state.tapFeedbacks
        .where((feedback) => feedback.id != feedbackId)
        .toList();
    emit(state.copyWith(tapFeedbacks: updatedFeedbacks));
  }

  void setSimulationMode(SimulationMode mode) {
    LoggerService.info('Simulation mode changed to: ${mode.name}');
    final gravity = _getGravityForMode(mode);
    emit(state.copyWith(
      simulationMode: mode,
      gravity: gravity,
    ));
  }

  void setGravity(double gravity) {
    if (gravity < 500.0 || gravity > 5000.0) return;
    LoggerService.debug('Gravity changed to: $gravity');
    emit(state.copyWith(gravity: gravity));
  }

  void setFrictionEnabled(bool enabled) {
    LoggerService.debug('Friction ${enabled ? 'enabled' : 'disabled'}');
    emit(state.copyWith(frictionEnabled: enabled));
  }

  void setBounceLevel(double level) {
    if (level < 0.1 || level > 1.0) return;
    LoggerService.debug('Bounce level changed to: $level');
    emit(state.copyWith(bounceLevel: level));
  }

  void resetSimulation() {
    LoggerService.info('Simulation reset');
    startGame();
  }

  @override
  Future<void> close() {
    LoggerService.info('GameCubit closed');
    _lastUpdateTime = null;
    return super.close();
  }
}
