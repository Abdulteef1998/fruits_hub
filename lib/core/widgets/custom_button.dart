import 'package:ecomerce_market/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPress, required this.text});
  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        onPressed: onPress,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
