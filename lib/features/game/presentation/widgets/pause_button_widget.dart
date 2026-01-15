import 'package:ball_physics/core/constants/game_constants.dart';
import 'package:ball_physics/core/shared/widgets/glass_card.dart';
import 'package:ball_physics/core/theme/app_border_radius.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:ball_physics/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PauseButtonWidget extends StatelessWidget {
  final bool isPaused;
  final VoidCallback onPressed;

  const PauseButtonWidget({
    super.key,
    required this.isPaused,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: GameConstants.pauseButtonTopPadding,
      right: GameConstants.pauseButtonRightPadding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppBorderRadius.pill),
          child: GlassCard(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              color: AppColors.textPrimary,
              size: GameConstants.pauseButtonIconSize,
            ),
          ),
        ),
      ),
    );
  }
}
