import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/data/constants/navigation_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/tap_feedback.dart';
import '../cubit/game_cubit.dart';
import '../cubit/game_state.dart';
import '../widgets/ball_widget.dart';
import '../widgets/ball_shadow_widget.dart';
import '../widgets/floor_widget.dart';
import '../widgets/score_widget.dart';
import '../widgets/pause_button_widget.dart';
import '../widgets/pause_dialog_widget.dart';
import '../widgets/tap_feedback_widget.dart';
import '../widgets/control_panel_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  Ticker? _ticker;
  GameCubit? _gameCubit;
  bool _showControlPanel = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gameCubit ??= context.read<GameCubit>();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gameCubit?.startGame();
      _startPhysicsUpdate();
    });
  }

  void _startPhysicsUpdate() {
    _ticker?.dispose();
    _ticker = createTicker((_) {
      if (!mounted || _gameCubit == null) return;
      final screenSize = MediaQuery.of(context).size;
      _gameCubit!.updatePhysics(screenSize.width, screenSize.height);
    });
    _ticker?.start();
  }

  void _stopPhysicsUpdate() {
    _ticker?.stop();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _gameCubit?.stopGame();
    super.dispose();
  }

  void _handlePauseButton() {
    final cubit = _gameCubit;
    if (cubit == null) return;
    final state = cubit.state;

    if (state.isPaused) {
      cubit.resumeGame();
      _startPhysicsUpdate();
      return;
    }

    cubit.pauseGame();
    _stopPhysicsUpdate();
    _showPauseDialog();
  }

  void _onTapDown(TapDownDetails details) {
    final cubit = _gameCubit;
    if (cubit == null) return;
    final screenSize = MediaQuery.of(context).size;
    cubit.onTap(
      details.localPosition.dx,
      details.localPosition.dy,
      screenSize.width,
      screenSize.height,
    );
  }

  void _showPauseDialog() {
    final cubit = _gameCubit;
    if (cubit == null) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => WillPopScope(
        onWillPop: () async {
          cubit.resumeGame();
          _startPhysicsUpdate();
          return true;
        },
        child: PauseDialogWidget(
          onContinue: () {
            cubit.resumeGame();
            _startPhysicsUpdate();
          },
          onMenu: () {
            Navigator.of(dialogContext, rootNavigator: true).pop();
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted) {
                cubit.stopGame();
                context.go(NavigationConstants.home);
              }
            });
          },
        ),
      ),
    );
  }

  List<Widget> _buildTapFeedbacks(
    List<TapFeedback> tapFeedbacks,
  ) {
    final cubit = _gameCubit;
    if (cubit == null) return [];
    
    return tapFeedbacks
        .map(
          (feedback) => TapFeedbackWidget(
            feedback: feedback,
            onAnimationComplete: () {
              cubit.removeTapFeedback(feedback.id);
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return GestureDetector(
            onTapDown: _onTapDown,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.gameBackground,
                    AppColors.backgroundSecondary,
                  ],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    const FloorWidget(),
                    BallShadowWidget(
                      ballX: state.ballX,
                      ballY: state.ballY,
                      screenWidth: screenSize.width,
                      screenHeight: screenSize.height,
                    ),
                    BallWidget(
                      ballX: state.ballX,
                      ballY: state.ballY,
                      screenWidth: screenSize.width,
                      screenHeight: screenSize.height,
                    ),
                    ..._buildTapFeedbacks(state.tapFeedbacks),
                    ScoreWidget(score: state.score),
                    PauseButtonWidget(
                      isPaused: state.isPaused,
                      onPressed: _handlePauseButton,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _showControlPanel = !_showControlPanel;
                          });
                        },
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          _showControlPanel ? Icons.close : Icons.tune,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showControlPanel)
                      ControlPanelWidget(
                        onClose: () {
                          setState(() {
                            _showControlPanel = false;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
