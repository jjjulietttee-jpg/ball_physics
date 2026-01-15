import 'package:go_router/go_router.dart';
import '../../data/constants/navigation_constants.dart';
import '../../data/utils/page_transitions.dart';
import '../../../../features/home/presentation/view/home_screen.dart';
import '../../../../features/menu/presentation/view/menu_screen.dart';
import '../../../../features/game/presentation/view/game_screen.dart';
import '../../../../features/leaderboard/presentation/screens/leaderboard_screen.dart';
import '../../../../features/learn/presentation/view/learn_screen.dart';
import '../../../../features/settings/presentation/view/settings_screen.dart';
import '../../../../features/physics_modes/presentation/view/physics_modes_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: NavigationConstants.home,
    routes: [
      GoRoute(
        path: NavigationConstants.home,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const HomeScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.menu,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const MenuScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.game,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const GameScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.leaderboard,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const LeaderboardScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.learn,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const LearnScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.settings,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const SettingsScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: NavigationConstants.physicsModes,
        pageBuilder: (context, state) => PageTransitions.slideTransition(
          child: const PhysicsModesScreen(),
          state: state,
        ),
      ),
    ],
  );
}
