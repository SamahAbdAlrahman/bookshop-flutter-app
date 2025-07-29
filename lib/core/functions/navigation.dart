import 'package:flutter/material.dart';

class NavigatorHelper {
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  // تستبدل الصفحة الحالية (ما تقدر ترجع)
  static void navigateToReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
