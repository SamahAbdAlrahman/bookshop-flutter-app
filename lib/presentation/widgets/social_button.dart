import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class socialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const socialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.facebookBlue),
            const SizedBox(width: 8),
            Text(label, style: AppTextStyles.heading),
          ],
        ),
      ),
    );
  }
}
