import 'package:flutter/material.dart';

class NavigationConstants {
  static const String home = '/';
  static const String menu = '/menu';
  static const String game = '/game';
  static const String settings = '/settings';
  static const String leaderboard = '/leaderboard';
  static const String learn = '/learn';
  static const String physicsModes = '/physics-modes';
  
  static const Duration fastTransition = Duration(milliseconds: 200);
  static const Duration normalTransition = Duration(milliseconds: 350);
  static const Duration slowTransition = Duration(milliseconds: 500);
  
  static const Curve easeInOutCurve = Curves.easeInOut;
  static const Curve easeOutBackCurve = Curves.easeOutBack;
  static const Curve fastOutSlowInCurve = Curves.fastOutSlowIn;
}