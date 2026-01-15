import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Soft Gradient Colors
  static const Color gradientStart = Color(0xFFF8F9FA); // Very light gray
  static const Color gradientEnd = Color(0xFFE9ECEF); // Light gray
  static const Color gradientAccent = Color(0xFFF1F3F5); // Soft blue-gray

  // Primary Colors (Soft Purple/Blue)
  static const Color primary = Color(0xFF6C5CE7); // Soft purple
  static const Color primaryLight = Color(0xFF8B7ED8);
  static const Color primaryDark = Color(0xFF5A4FCF);

  // Accent Colors
  static const Color accentBlue = Color(0xFF4C7DFF);
  static const Color accentCyan = Color(0xFF67D1C5);
  static const Color accentOrange = Color(0xFFFFB74D);

  // Ball Colors
  static const Color ballOrange = Color(0xFFFFB74D);
  static const Color ballOrangeDark = Color(0xFFE64A19);
  static const Color ballGlow = Color(0x40FFB74D); // Orange glow

  // Background Colors
  static const Color background = Color(0xFFFAFBFC);
  static const Color backgroundSecondary = Color(0xFFF5F6F8);
  static const Color gameBackground = Color(0xFFF8F9FA);

  // Surface Colors
  static const Color surface = Colors.white;
  static const Color surfaceLight = Color(0xFFFAFBFC);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Shadow & Glow
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color glowPrimary = Color(0x406C5CE7);
  static const Color glowOrange = Color(0x40FFB74D);

  // Glass Effect
  static const Color glassBg = Color(0x80FFFFFF);
  static const Color glassBorder = Color(0x40FFFFFF);

  // Ball Shadow
  static const Color ballShadow = Color(0x40000000);

  // Floor
  static const Color floorLight = Color(0xFFFFFFFF);
  static const Color floorDark = Color(0xFFF5F6F8);

  // Legacy colors for backward compatibility
  static const Color whiteColor = surface;
  static const Color blackColor = textPrimary;
  static const Color scaffoldBgColor = background;
  static const Color primaryColor = primary;
  static const Color primaryColor50 = Color.fromARGB(128, 108, 92, 231); // primary with 0.5 opacity
  static const Color secondaryGradientBlue = accentBlue;
  static const Color ballOrangeLight = ballOrange;
  static const Color greyColor = textSecondary;
  static const Color menuBackgroundLight = backgroundSecondary;
  static const Color gameBackgroundPrimary = primary;
  static const Color gameBackgroundSecondary = accentCyan;
  static const Color scoreBackground = textPrimary;
  static const Color pauseButtonBackground = textPrimary;
  static const Color floorGradientLight = floorLight;
  static const Color floorGradientDark = floorDark;
  
  // Legacy shadow and white colors with opacity
  static const Color shadowBlack12 = Color.fromARGB(31, 0, 0, 0); // 0.12 opacity
  static const Color whiteColor26 = Color.fromARGB(66, 255, 255, 255); // 0.26 opacity
  static const Color whiteColor06 = Color.fromARGB(15, 255, 255, 255); // 0.06 opacity

  // Opacity values
  static const double opacity08 = 0.8;
  static const double opacity07 = 0.7;
  static const double opacity06 = 0.6;
  static const double opacity05 = 0.5;
  static const double opacity04 = 0.4;
  static const double opacity03 = 0.3;
  static const double opacity02 = 0.2;
  static const double opacity095 = 0.95;
}
