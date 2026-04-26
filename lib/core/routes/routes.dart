import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';

import 'package:se7etee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7etee/features/doctor/presentation/page/doctor_registration.dart';
import 'package:se7etee/features/auth/presentation/page/login_screen.dart';
import 'package:se7etee/features/auth/presentation/page/resgister_screen.dart';

import 'package:se7etee/features/intro/splash/splash_screen.dart';
import 'package:se7etee/features/intro/on_boarding/on_boarding_screen.dart';
import 'package:se7etee/features/intro/welcome/welcome_screen.dart';
import 'package:se7etee/features/patient/main/patient_main_app_screen.dart';

var globalContext = GlobalKey<NavigatorState>();

class Routes {
  static const String root = '/';
  static const String splashscreen = '/splashscreen';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String patientMainApp = '/patientMainApp';
  static const String doctorMainApp = '/doctorMainApp';
  static const String doctorUpdateProfile = '/doctorUpdateProfile';
  static const String homeSearchscreen = '/homeSearchscreen';
    static const String specializationSearch = '/specializationSearch';
      static const String homeSearch = '/homeSearch';
        static const String doctorProfile = '/doctorProfile';


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
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(userType: state.extra as UserTypeEnum),
        ),
      ),
      GoRoute(
        path: patientMainApp,
        builder: (context, state) => PatientMainAppScreen(),
      ),
      GoRoute(
        path: doctorUpdateProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: UpdateDoctorProfileScreen(),
        ),
      ),
      /*
      GoRoute(
        path: homeSearchscreen,
        builder: (context, state) =>
            HomeSearchScreen(searchKey: state.extra as String),
      ),
          GoRoute(
        path: specializationSearch,
        builder: (context, state) =>
            SpecializationSearchScreen(specialization: state.extra as String),
      ),
         GoRoute(
        path: homeSearch,
        builder: (context, state) =>
            HomeSearchScreen(searchKey: state.extra as String),
      ),*/
    ],
  );
}
