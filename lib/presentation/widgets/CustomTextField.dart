import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  // final String label;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    // required this.label,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        // labelText: label,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),

      ),
    );
  }
}
