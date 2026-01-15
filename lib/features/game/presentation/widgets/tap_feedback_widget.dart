import 'package:flutter/material.dart';
import '../../../../core/constants/feedback_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/tap_feedback.dart';

class TapFeedbackWidget extends StatefulWidget {
  final TapFeedback feedback;
  final VoidCallback onAnimationComplete;

  const TapFeedbackWidget({
    super.key,
    required this.feedback,
    required this.onAnimationComplete,
  });

  @override
  State<TapFeedbackWidget> createState() => _TapFeedbackWidgetState();
}

class _TapFeedbackWidgetState extends State<TapFeedbackWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        milliseconds: (FeedbackConstants.animationDuration * 1000).toInt(),
      ),
      vsync: this,
    );

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: FeedbackConstants.fadeOutStart,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 1.0 - FeedbackConstants.fadeOutStart,
      ),
    ]).animate(_controller);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.5, end: 1.2).chain(
          CurveTween(curve: Curves.elasticOut),
        ),
        weight: 0.3,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 0.7,
      ),
    ]).animate(_controller);

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -FeedbackConstants.moveUpDistance / 100),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward().then((_) {
      widget.onAnimationComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.feedback.x,
      top: widget.feedback.y,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryGradientBlue,
                ],
              ).createShader(bounds),
              child: Text(
                widget.feedback.text,
                style: const TextStyle(
                  fontSize: FeedbackConstants.fontSize,
                  fontWeight: FeedbackConstants.fontWeight,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

