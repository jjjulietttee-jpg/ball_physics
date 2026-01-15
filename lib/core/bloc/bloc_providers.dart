import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../navigation/presentation/cubit/navigation_cubit.dart';
import '../navigation/presentation/widgets/app_router.dart';
import '../navigation/data/constants/navigation_constants.dart';
import '../../features/game/presentation/cubit/game_cubit.dart';

final GetIt getIt = GetIt.instance;

class BlocProviders {
  BlocProviders._();

  static void setup() {
    _registerTalker();
    _registerNavigationCubit();
    _registerGameCubit();
  }

  static void _registerTalker() {
    getIt.registerLazySingleton<Talker>(
      () => TalkerFlutter.init(settings: TalkerSettings(enabled: true)),
    );
  }

  static void _registerNavigationCubit() {
    getIt.registerFactoryParam<NavigationCubit, String, bool>(
      (currentLocation, isDark) =>
          NavigationCubit(currentLocation: currentLocation, isDark: isDark),
    );
  }

  static void _registerGameCubit() {
    getIt.registerFactory<GameCubit>(() => GameCubit());
  }

  static Widget wrapWithProviders({
    required BuildContext context,
    required Widget child,
  }) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;

    String currentLocation;
    try {
      currentLocation =
          AppRouter.router.routerDelegate.currentConfiguration.uri.path;
      if (currentLocation.isEmpty) {
        currentLocation = NavigationConstants.menu;
      }
    } catch (_) {
      currentLocation = NavigationConstants.menu;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) =>
              getIt<NavigationCubit>(param1: currentLocation, param2: isDark),
        ),
        BlocProvider<GameCubit>(create: (_) => getIt<GameCubit>()),
      ],
      child: child,
    );
  }
}
