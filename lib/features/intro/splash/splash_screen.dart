import 'package:flutter/material.dart';
import 'package:se7etee/core/functions/navigation.dart';
import 'package:se7etee/core/routes/routes.dart';
import 'package:se7etee/core/services/local/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isOnboardingShown = SharedPref.isOnboardingShown();
    Future.delayed(const Duration(seconds: 3), () {
      if (isOnboardingShown) {
        pushReplacement(context, Routes.welcome);
      } else {
        pushReplacement(context, Routes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo.png', width: 250)),
    );
  }
}
