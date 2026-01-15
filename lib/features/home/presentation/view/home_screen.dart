import 'package:ball_physics/core/navigation/data/constants/navigation_constants.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:ball_physics/core/theme/app_fonts.dart';
import 'package:ball_physics/core/theme/app_spacing.dart';
import 'package:ball_physics/features/home/presentation/widgets/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),
                Text(
                  'Ball Physics',
                  style: AppFonts.displayLarge.copyWith(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Interactive Physics Simulation',
                  style: AppFonts.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.1,
                    children: [
                      FeatureCard(
                        title: 'Play Simulation',
                        icon: Icons.play_circle_outline,
                        color: AppColors.primary,
                        onTap: () {
                          context.go(NavigationConstants.game);
                        },
                      ),
                      FeatureCard(
                        title: 'Physics Modes',
                        icon: Icons.science_outlined,
                        color: AppColors.accentBlue,
                        onTap: () {
                          context.push(NavigationConstants.physicsModes);
                        },
                      ),
                      FeatureCard(
                        title: 'Learn Physics',
                        icon: Icons.school_outlined,
                        color: AppColors.accentCyan,
                        onTap: () {
                          context.push(NavigationConstants.learn);
                        },
                      ),
                      FeatureCard(
                        title: 'Settings',
                        icon: Icons.settings_outlined,
                        color: AppColors.accentOrange,
                        onTap: () {
                          context.push(NavigationConstants.settings);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
