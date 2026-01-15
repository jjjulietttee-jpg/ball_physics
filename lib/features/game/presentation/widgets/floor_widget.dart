import 'package:ball_physics/core/constants/game_constants.dart';
import 'package:ball_physics/core/theme/app_border_radius.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FloorWidget extends StatelessWidget {
  const FloorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: GameConstants.floorHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.floorLight,
              AppColors.floorDark,
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppBorderRadius.xl),
            topRight: Radius.circular(AppBorderRadius.xl),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        ),
      ),
    );
  }
}
