import 'package:flutter/material.dart';

class NavigationIcons {
  NavigationIcons._();

  static const IconData menu = Icons.menu;
  static const IconData game = Icons.sports_soccer;
  static const IconData settings = Icons.settings;
  
  static IconData getIconByRoute(String route) {
    switch (route) {
      case '/menu':
        return menu;
      case '/game':
        return game;
      case '/settings':
        return settings;
      default:
        return menu;
    }
  }
}

