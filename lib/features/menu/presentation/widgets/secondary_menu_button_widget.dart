import 'package:flutter/material.dart';
import '../../../../core/constants/menu_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';

class SecondaryMenuButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const SecondaryMenuButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MenuConstants.secondaryButtonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.whiteColor,
          side: BorderSide(
            color: AppColors.greyColor.withOpacity(AppColors.opacity03),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MenuConstants.buttonBorderRadius,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.greyColor,
              size: MenuConstants.buttonIconSize,
            ),
            const SizedBox(width: MenuConstants.buttonIconSpacing),
            Text(
              text,
              style: AppFonts.headlineMedium.copyWith(
                fontSize: MenuConstants.secondaryButtonFontSize,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

