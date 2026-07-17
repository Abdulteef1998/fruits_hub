import 'package:ecomerce_market/core/widgets/custom_app_bar.dart';
import 'package:ecomerce_market/features/auth/presentation/views/signup/widget/signup_view_body.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'حساب جديد'),
      body: const SignupViewBody(),
    );
  }
}
