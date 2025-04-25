import 'package:book_nest/utils/app_routes.dart';
import 'package:book_nest/utils/assets.dart';
import 'package:book_nest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _opacity = 0.0;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      GoRouter.of(context).pushReplacement(AppRoutesPaths.homeViewPath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: Center(
          child: AnimatedOpacity(
            duration: Duration(seconds: 3),
            opacity: _opacity,
            child: Image.asset(
              AppAssets.whiteLogo,
            ),
          ),
        ),
      ),
    );
  }
}
