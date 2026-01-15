import 'package:equatable/equatable.dart';
import '../../domain/models/tap_feedback.dart';

class GameState extends Equatable {
  final double ballX;
  final double ballY;
  final double velocityX;
  final double velocityY;
  final int score;
  final bool isPlaying;
  final bool isPaused;
  final bool justBouncedFromFloor;
  final List<TapFeedback> tapFeedbacks;

  const GameState({
    this.ballX = 0.5,
    this.ballY = 0.3,
    this.velocityX = 0.0,
    this.velocityY = 0.0,
    this.score = 0,
    this.isPlaying = false,
    this.isPaused = false,
    this.justBouncedFromFloor = false,
    this.tapFeedbacks = const [],
  });

  GameState copyWith({
    double? ballX,
    double? ballY,
    double? velocityX,
    double? velocityY,
    int? score,
    bool? isPlaying,
    bool? isPaused,
    bool? justBouncedFromFloor,
    List<TapFeedback>? tapFeedbacks,
  }) {
    return GameState(
      ballX: ballX ?? this.ballX,
      ballY: ballY ?? this.ballY,
      velocityX: velocityX ?? this.velocityX,
      velocityY: velocityY ?? this.velocityY,
      score: score ?? this.score,
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      justBouncedFromFloor: justBouncedFromFloor ?? this.justBouncedFromFloor,
      tapFeedbacks: tapFeedbacks ?? this.tapFeedbacks,
    );
  }

  @override
  List<Object> get props => [
    ballX,
    ballY,
    velocityX,
    velocityY,
    score,
    isPlaying,
    isPaused,
    justBouncedFromFloor,
    tapFeedbacks,
  ];
}
