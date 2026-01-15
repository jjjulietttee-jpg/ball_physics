import 'package:ball_physics/core/bloc/bloc_providers.dart';
import 'package:ball_physics/core/navigation/presentation/widgets/app_router.dart';
import 'package:ball_physics/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  BlocProviders.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ball Physics',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return BlocProviders.wrapWithProviders(
          context: context,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
