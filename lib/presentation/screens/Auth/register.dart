import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/API/auth_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/functions/navigation.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/social_button.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  final AuthService authService = AuthService();
  bool agree = false;

  bool isLoading = false;

  void handleRegister() async {
    setState(() {
      isLoading = true;
    });

    bool success = await authService.register(
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      passwordConfirmController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! ')),
      );
    // روح عالشاشة الرئيسية
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please check your inputs.')),
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
                'Register',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 15),

              // Name Label
              Text('Name', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: nameController,
                hintText: 'John Smith',
              ),

              const SizedBox(height: 15),

              // Email Label
              Text('Email', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: emailController,
                hintText: 'Example@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 15),

              // Password Label
              Text('Password', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: passwordController,
                hintText: '**********',
                obscureText: true,
              ),

              const SizedBox(height: 22),

              // Password Confirmation Label
              Text('Confirm Password', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: passwordConfirmController,
                hintText: '**********',
                obscureText: true,
              ),
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value ?? false;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Agree with ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),

              // Register Button
              PrimaryButton(
                text: 'Create account',
                onPressed: handleRegister,
                isLoading: isLoading,
              ),

              const SizedBox(height: 15),
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
              const SizedBox(height: 15),

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

              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigatorHelper.navigateTo(context, LoginScreen());
                    },
                    child: Text(
                      'Log in',
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
