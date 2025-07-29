import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_project/presentation/screens/Auth/forget_password.dart';
import 'package:my_project/presentation/screens/Auth/login.dart';
import 'package:my_project/presentation/screens/Auth/register.dart';
import 'package:my_project/presentation/screens/Auth/reset_pass.dart';
import 'package:my_project/presentation/screens/splash/splash1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,

      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(),
        ),
        home: LoginScreen(),
      ),
    );

  }
}

