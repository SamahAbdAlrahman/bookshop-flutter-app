import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/functions/navigation.dart';
import '../../widgets/primary_button.dart';
import '../Auth/login.dart';
import '../Auth/register.dart';


class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book_outlined,
                    color: Colors.white,
                    size: 85,
                  ),

                  Text(
                    'Bookshop',
                    style: AppTextStyles.heading.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                ],),

                const SizedBox(height: 60),

                SizedBox(
                  width: 343.sp,
                  height: 50.sp,
                  child: PrimaryButton(
                    text: 'Log in',
                    onPressed: () {
                      NavigatorHelper.navigateTo(context, const LoginScreen());
                    },
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                    width: 343.sp,
                    height: 50.sp,
                  child: PrimaryButton(
                    text: 'Create account',
                    onPressed: () {
                      NavigatorHelper.navigateTo(context, const RegisterScreen());
                    },
                    backgroundColor: Colors.white,
                    textColor: AppColors.primary,
                  )

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
