import 'package:flutter/material.dart';
import 'package:my_project/presentation/screens/Auth/send_code.dart';
import '../../../core/API/auth_service.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/functions/navigation.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/primary_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;

  void handleForgetPassword() async {
    setState(() {
      isLoading = true;
    });

    bool success = await authService.forgetPassword(emailController.text.trim());

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset email sent. Check your inbox!')),
      );
      NavigatorHelper.navigateToReplacement(context,SendCodeScreen(email: emailController.text.trim(),));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send reset email. Try again.')),
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
              Text('Forget password', style: AppTextStyles.heading),
              const SizedBox(height: 65),
              Center(
                child: SizedBox(
                  width: 170,
                  child: Text(
                    'Enter your email to reset your password',
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Text('Email', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: emailController,
                hintText: 'Example@gmail.com',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 30),
              PrimaryButton(
                text: 'Send code',
                onPressed:handleForgetPassword,
                isLoading: isLoading,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
