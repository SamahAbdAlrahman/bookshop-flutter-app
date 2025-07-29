import 'package:flutter/material.dart';
import 'package:my_project/presentation/screens/Auth/register.dart';
import '../../../core/API/auth_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/functions/navigation.dart';
import '../../widgets/CustomTextField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/primary_button.dart';
import '../../widgets/social_button.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();

  bool isLoading = false;

  void handleLogin() async {
    setState(() {
      isLoading = true;
    });

    bool success = await authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (success) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('done')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in',
                style: AppTextStyles.heading,

              ),
              const SizedBox(height: 40),

              // Email Label
              Text('Email',
                style: AppTextStyles.heading,

              ),
              const SizedBox(height: 6),

              CustomTextField(
                controller: emailController,
                // label: 'Email',
                hintText: 'Example@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),


              const SizedBox(height: 22),
              // Password Label
              Text('Password',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 6),
              CustomTextField(
                controller: passwordController,
                // label: 'Password',
                hintText: '**********',
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      NavigatorHelper.navigateTo(context,ForgetPasswordScreen());
                    },
                    child: Text(
                      'Forget your password?',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Login Button
              PrimaryButton(
                text: 'Log in',
                onPressed: handleLogin,
                isLoading: isLoading,
              ),

              const SizedBox(height: 30),

              // Or login with
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or login with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialButton(
                    icon: FontAwesomeIcons.facebook,
                    label: 'Facebook',
                    onTap: () {
                    },),
                  socialButton(
                    icon: FontAwesomeIcons.google,
                    label: 'Google',
                    onTap: () {
                    },),


                ],
              ),
              const SizedBox(height: 20),

              // Sign up prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                  GestureDetector(
                    onTap: () {
                      NavigatorHelper.navigateTo(context, RegisterScreen());

                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
