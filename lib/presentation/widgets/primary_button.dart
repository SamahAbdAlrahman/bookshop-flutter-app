import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor; // اختياري لون الخلفية
  final Color? textColor;       // اختياري لون النص

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.primary;
    final txtColor = textColor ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(color: txtColor)
            : Text(
          text,
          style: AppTextStyles.btnText.copyWith(color: txtColor),
        ),
      ),
    );
  }
}
