import 'package:ball_physics/core/constants/game_constants.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BallWidget extends StatelessWidget {
  final double ballX;
  final double ballY;
  final double screenWidth;
  final double screenHeight;

  const BallWidget({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: ballX * screenWidth - GameConstants.ballRadius,
      top: ballY * screenHeight - GameConstants.ballRadius,
      child: Container(
        width: GameConstants.ballRadius * 2,
        height: GameConstants.ballRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [
              AppColors.ballOrange,
              AppColors.ballOrangeDark,
            ],
            stops: [0.0, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.glowOrange,
              blurRadius: 20,
              spreadRadius: 3,
            ),
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}
