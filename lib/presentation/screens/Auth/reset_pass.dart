import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/primary_button.dart';
import '../../../core/API/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String verifyCode;

  const ResetPasswordScreen({super.key, required this.email, required this.verifyCode});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  bool isLoading = false;

  void handleResetPassword() async {
    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() => isLoading = true);

    bool success = await authService.resetPassword(widget.email, widget.verifyCode, newPassword, confirmPassword);

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful!')),

      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid code or error resetting password')),
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
              Text('Reset password', style: AppTextStyles.heading),
              const SizedBox(height: 70),
              Center(
                child: SizedBox(
                  width: 240,
                  child: Text(
                    'Your new password must be different from previous one',
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text('Password', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: passwordController,
                hintText: '**********',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Text('Confirm password', style: AppTextStyles.heading),
              const SizedBox(height: 6),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: '**********',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                text: 'Reset password',
                onPressed: handleResetPassword,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
