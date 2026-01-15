import 'package:ball_physics/core/shared/widgets/glass_card.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:ball_physics/core/theme/app_fonts.dart';
import 'package:ball_physics/core/theme/app_spacing.dart';
import 'package:ball_physics/features/game/domain/models/simulation_mode.dart';
import 'package:flutter/material.dart';

class ModeCard extends StatelessWidget {
  final SimulationMode mode;
  final VoidCallback onTap;

  const ModeCard({
    super.key,
    required this.mode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    IconData icon;

    switch (mode) {
      case SimulationMode.classic:
        cardColor = AppColors.primary;
        icon = Icons.science;
        break;
      case SimulationMode.gravityLab:
        cardColor = AppColors.accentBlue;
        icon = Icons.explore;
        break;
      case SimulationMode.chaosMode:
        cardColor = AppColors.accentOrange;
        icon = Icons.shuffle;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: cardColor,
                size: 32,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.name,
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    mode.description,
                    style: AppFonts.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
