import 'package:go_router/go_router.dart';
import '../../data/constants/navigation_constants.dart';
import '../../data/utils/page_transitions.dart';
import '../../../../features/menu/presentation/view/menu_screen.dart';
import '../../../../features/game/presentation/view/game_screen.dart';
import '../../../../features/leaderboard/presentation/screens/leaderboard_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: NavigationConstants.menu,
    routes: [
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
    ],
  );
}
