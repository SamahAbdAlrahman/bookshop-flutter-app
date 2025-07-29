import 'package:flutter/material.dart';
import 'package:my_project/presentation/screens/splash/splash2.dart';

import '../../../core/functions/navigation.dart';
import '../Auth/register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      NavigatorHelper.navigateTo(context, SplashScreen2());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/background.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
