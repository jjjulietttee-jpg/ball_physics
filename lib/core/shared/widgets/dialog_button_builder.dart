import 'package:flutter/material.dart';
import '../../constants/game_constants.dart';
import '../../constants/menu_constants.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_fonts.dart';

class DialogButtonBuilder {
  DialogButtonBuilder._();

  static Widget buildPrimaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: MenuConstants.playButtonHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.whiteColor,
            AppColors.whiteColor.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(
          GameConstants.dialogButtonBorderRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            GameConstants.dialogButtonBorderRadius,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: AppFonts.headlineLarge.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: GameConstants.dialogButtonFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildSecondaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: MenuConstants.secondaryButtonHeight,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          GameConstants.dialogButtonBorderRadius,
        ),
        border: Border.all(
          color: AppColors.whiteColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            GameConstants.dialogButtonBorderRadius,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColors.whiteColor,
                  size: MenuConstants.buttonIconSize,
                ),
                const SizedBox(width: MenuConstants.buttonIconSpacing),
                Text(
                  text,
                  style: AppFonts.headlineMedium.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: GameConstants.dialogButtonFontSize,
                    fontWeight: FontWeight.bold,
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

