import 'package:book_nest/features/home_screen/presentation/views/home_view.dart';
import 'package:book_nest/features/splash_screen/splash_screen_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final router = GoRouter(routes: [
    GoRoute(
      path: AppRoutesPaths.splashViewPath,
      builder: (context, state) => const SplashScreenView(),
    ),
    GoRoute(
      path: AppRoutesPaths.homeViewPath,
      builder: (context, state) => HomeView(),
    )
  ]);
}

class AppRoutesPaths {
  static const String splashViewPath = '/';
  static const String homeViewPath = '/homeViewPath';
}
