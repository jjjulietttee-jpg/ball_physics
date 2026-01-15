import 'package:ball_physics/core/navigation/data/constants/navigation_constants.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:ball_physics/core/theme/app_fonts.dart';
import 'package:ball_physics/core/theme/app_spacing.dart';
import 'package:ball_physics/features/game/domain/models/simulation_mode.dart';
import 'package:ball_physics/features/game/presentation/cubit/game_cubit.dart';
import 'package:ball_physics/features/physics_modes/presentation/widgets/mode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PhysicsModesScreen extends StatelessWidget {
  const PhysicsModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Modes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
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
                Text(
                  'Choose Simulation Mode',
                  style: AppFonts.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Each mode offers a different physics experience',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Expanded(
                  child: ListView(
                    children: [
                      ModeCard(
                        mode: SimulationMode.classic,
                        onTap: () {
                          context.read<GameCubit>().setSimulationMode(
                                SimulationMode.classic,
                              );
                          context.go(NavigationConstants.game);
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ModeCard(
                        mode: SimulationMode.gravityLab,
                        onTap: () {
                          context.read<GameCubit>().setSimulationMode(
                                SimulationMode.gravityLab,
                              );
                          context.go(NavigationConstants.game);
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ModeCard(
                        mode: SimulationMode.chaosMode,
                        onTap: () {
                          context.read<GameCubit>().setSimulationMode(
                                SimulationMode.chaosMode,
                              );
                          context.go(NavigationConstants.game);
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
