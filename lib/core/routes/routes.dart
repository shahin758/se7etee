import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/features/auth/presentation/page/login_screen.dart';
import 'package:se7etee/features/auth/presentation/page/resgister_screen.dart';
import 'package:se7etee/features/intro/splash/splash_screen.dart';
import 'package:se7etee/features/intro/on_boarding/on_boarding_screen.dart';
import 'package:se7etee/features/intro/welcome/welcome_screen.dart';

var globalContext = GlobalKey<NavigatorState>();

class Routes {
  static const String root = '/';
  static const String splashscreen = '/splashscreen';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';

  static final GoRouter router = GoRouter(
    navigatorKey: globalContext,
    initialLocation: splashscreen,
    routes: [
      GoRoute(path: splashscreen, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) =>
            LoginScreen(userType: state.extra as UserTypeEnum),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => RegisterScreen(userType: state.extra as UserTypeEnum),
      ),
    ],
  );
}
