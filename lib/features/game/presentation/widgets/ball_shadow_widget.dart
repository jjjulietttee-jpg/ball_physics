import 'package:ball_physics/core/constants/game_constants.dart';
import 'package:ball_physics/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BallShadowWidget extends StatelessWidget {
  final double ballX;
  final double ballY;
  final double screenWidth;
  final double screenHeight;

  const BallShadowWidget({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double floorY = screenHeight - GameConstants.floorHeight;
    final double ballScreenY = ballY * screenHeight;
    final double distanceFromFloor = (floorY - ballScreenY).abs();
    final double maxDistance = screenHeight * GameConstants.shadowMaxDistanceMultiplier;
    
    final double shadowOpacity = (1.0 - (distanceFromFloor / maxDistance).clamp(0.0, 1.0)) * GameConstants.shadowMaxOpacity;
    final double shadowSize = GameConstants.ballRadius * GameConstants.shadowSizeMultiplier;
    final double shadowHeight = GameConstants.ballRadius * GameConstants.shadowHeightMultiplier;
    
    return Positioned(
      left: ballX * screenWidth - shadowSize * 0.5,
      top: screenHeight - GameConstants.floorHeight - shadowHeight * 0.5,
      child: Opacity(
        opacity: shadowOpacity.clamp(0.0, 0.4),
        child: Container(
          width: shadowSize,
          height: shadowHeight,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.ballShadow,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
