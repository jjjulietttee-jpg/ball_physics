import 'package:ball_physics/core/shared/widgets/glass_card.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:ball_physics/core/theme/app_fonts.dart';
import 'package:ball_physics/core/theme/app_spacing.dart';
import 'package:ball_physics/features/game/presentation/cubit/game_cubit.dart';
import 'package:ball_physics/features/game/presentation/cubit/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlPanelWidget extends StatelessWidget {
  final VoidCallback? onClose;

  const ControlPanelWidget({
    super.key,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Positioned(
          bottom: AppSpacing.lg,
          left: AppSpacing.md,
          right: AppSpacing.md,
          child: GlassCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Controls',
                      style: AppFonts.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textPrimary),
                      onPressed: onClose,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _GravitySlider(state: state),
                const SizedBox(height: AppSpacing.md),
                _FrictionToggle(state: state),
                const SizedBox(height: AppSpacing.md),
                _BounceSelector(state: state),
                const SizedBox(height: AppSpacing.md),
                _ResetButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GravitySlider extends StatelessWidget {
  final GameState state;

  const _GravitySlider({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gravity',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${(state.gravity / 100).round()}',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Slider(
          value: state.gravity,
          min: 500.0,
          max: 5000.0,
          divisions: 45,
          activeColor: AppColors.primary,
          onChanged: (value) {
            context.read<GameCubit>().setGravity(value);
          },
        ),
      ],
    );
  }
}

class _FrictionToggle extends StatelessWidget {
  final GameState state;

  const _FrictionToggle({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Friction',
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        Switch(
          value: state.frictionEnabled,
          activeColor: AppColors.primary,
          onChanged: (value) {
            context.read<GameCubit>().setFrictionEnabled(value);
          },
        ),
      ],
    );
  }
}

class _BounceSelector extends StatelessWidget {
  final GameState state;

  const _BounceSelector({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bounce Level',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${(state.bounceLevel * 100).round()}%',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Slider(
          value: state.bounceLevel,
          min: 0.1,
          max: 1.0,
          divisions: 9,
          activeColor: AppColors.primary,
          onChanged: (value) {
            context.read<GameCubit>().setBounceLevel(value);
          },
        ),
      ],
    );
  }
}

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<GameCubit>().resetSimulation();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Reset Simulation',
          style: AppFonts.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
