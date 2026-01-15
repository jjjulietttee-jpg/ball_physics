import '../models/navigation_item.dart';
import 'navigation_constants.dart';
import 'navigation_labels.dart';

class BottomNavigationConstants {
  BottomNavigationConstants._();

  // Для игры bottom navigation не используется, но оставляем для совместимости
  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      iconPath: '', // Не используется для простой навигации
      label: NavigationLabels.menu,
      route: NavigationConstants.menu,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.game,
      route: NavigationConstants.game,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.settings,
      route: NavigationConstants.settings,
    ),
  ];
}
