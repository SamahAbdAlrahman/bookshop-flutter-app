import 'package:flutter/material.dart';
import 'package:my_project/presentation/screens/Auth/reset_pass.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/functions/navigation.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/primary_button.dart';
import '../../../core/API/auth_service.dart';

class SendCodeScreen extends StatefulWidget {
  final String email;
  const SendCodeScreen({super.key, required this.email});

  @override
  State<SendCodeScreen> createState() => _SendCodeScreenState();
}

class _SendCodeScreenState extends State<SendCodeScreen> {
  final List<TextEditingController> codeControllers = List.generate(4, (_) => TextEditingController());
  bool isLoading = false;
  final AuthService authService = AuthService();

  @override
  void dispose() {
    for (var controller in codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void handleResetPassword() async {
    final code = codeControllers.map((c) => c.text).join();
    if (code.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit code')),
      );
      return;
    }

    setState(() => isLoading = true);

    bool success = await authService.verifyForgetPasswordCode(widget.email, code);

    setState(() => isLoading = false);

    if (success) {
      // نجح التحقق،
      // ننتقل لصفحة تغيير كلمة السر

      NavigatorHelper.navigateTo(
          context,
          ResetPasswordScreen(
        email: widget.email,
        verifyCode: code,));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid verification code')),
      );
    }
  }

  void handleSendAgain() async {
    setState(() => isLoading = true);

    bool sent = await authService.forgetPassword(widget.email);

    setState(() => isLoading = false);

    if (sent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code resent! Check your email.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to resend code. Try again later.')),
      );
    }
  }

  Widget buildCodeTextField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: codeControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: AppTextStyles.heading.copyWith(fontSize: 24),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter code', style: AppTextStyles.heading),
            const SizedBox(height: 70),

            Center(
              child: SizedBox(
                width: 220,
                child: Text(
                  'Enter the 4 digits code that you received on your email',
                  style: AppTextStyles.heading,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => buildCodeTextField(index)),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              text: 'Reset password',
              onPressed: handleResetPassword,
              isLoading: isLoading,
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t receive a code? ", style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: handleSendAgain,
                  child: Text(
                    'Send again',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
