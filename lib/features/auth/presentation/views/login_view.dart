import 'package:ecomerce_market/core/widgets/custom_app_bar.dart';
import 'package:ecomerce_market/features/auth/presentation/views/login_view_body.dart';
import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});
  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'تسجيل دخول'),
      body: LoginViewBody(),
    );
  }
}
