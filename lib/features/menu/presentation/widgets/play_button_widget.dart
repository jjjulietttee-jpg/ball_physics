import 'package:flutter/material.dart';
import '../../../../core/constants/menu_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_fonts.dart';

class PlayButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const PlayButtonWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MenuConstants.playButtonHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryGradientBlue,
          ],
        ),
        borderRadius: BorderRadius.circular(
          MenuConstants.buttonBorderRadius,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MenuConstants.buttonBorderRadius,
            ),
          ),
        ),
        child: Text(
          'Play',
          style: AppFonts.headlineLarge.copyWith(
            color: AppColors.whiteColor,
            fontSize: MenuConstants.playButtonFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

