import 'package:flutter/material.dart';
import '../../../../core/constants/menu_constants.dart';
import '../../../../core/theme/app_colors.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MenuConstants.appIconSize,
      height: MenuConstants.appIconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MenuConstants.appIconBorderRadius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, AppColors.secondaryGradientBlue],
        ),
      ),
      child: Center(
        child: Container(
          width: MenuConstants.ballIconSize,
          height: MenuConstants.ballIconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [AppColors.ballOrangeLight, AppColors.ballOrangeDark],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.ballOrangeDark.withOpacity(
                  AppColors.opacity05,
                ),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
