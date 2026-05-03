import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7etee/core/constants/user_type_enum.dart';
import 'package:se7etee/features/auth/data/model/doctor_model.dart';

import 'package:se7etee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7etee/features/doctor/presentation/page/doctor_registration.dart';
import 'package:se7etee/features/auth/presentation/page/login_screen.dart';
import 'package:se7etee/features/auth/presentation/page/resgister_screen.dart';

import 'package:se7etee/features/intro/splash/splash_screen.dart';
import 'package:se7etee/features/intro/on_boarding/on_boarding_screen.dart';
import 'package:se7etee/features/intro/welcome/welcome_screen.dart';
import 'package:se7etee/features/patient/appointements/appointments_list.dart';
import 'package:se7etee/features/patient/appointements/appointments_screen.dart';
import 'package:se7etee/features/patient/booking/presentation/pages/booking_screen.dart';
import 'package:se7etee/features/patient/settings/settings_screen.dart';
import 'package:se7etee/features/patient/settings/user_details.dart';
import 'package:se7etee/features/search/doctor_profile/page/doctor_profile_screen.dart';
import 'package:se7etee/features/search/specialization_search/page/speacialization_screen.dart';
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
  static const String bookingScreen = '/bookingScreen';
  static const String appointmentScreen = '/appointmentScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String userDetails = '/userDetails';
  

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
      GoRoute(
        path: specializationSearch,
        builder: (context, state) =>
            SpecializationSearchScreen(specialization: state.extra as String),
      ),
      GoRoute(
        path: doctorProfile,
        builder: (context, state) =>
            DoctorProfileScreen(doctorModel: state.extra as DoctorModel),
      ),
      GoRoute(
        path: bookingScreen,
        builder: (context, state) =>
            BookingScreen(doctor: state.extra as DoctorModel),
      ),
      GoRoute(
        path: appointmentScreen,
        builder: (context, state) => MyAppointmentsScreen(),
      ),
      GoRoute(
        path: settingsScreen,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: userDetails,
        builder: (context, state) => UserDetails(),
      ),
    ],
  );
}
