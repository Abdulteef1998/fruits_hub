import 'package:ecomerce_market/core/utils/app_colors.dart';
import 'package:ecomerce_market/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: ' لا تمتلك حساب؟',
        style: TextStyles.semiBold13.copyWith(color: Color(0xFF949D9E)),
        children: [
          TextSpan(
            text: ' قم بإنشاء حساب',
            style: TextStyles.semiBold13.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
