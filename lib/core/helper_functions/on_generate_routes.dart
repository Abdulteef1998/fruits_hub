import 'package:ecomerce_market/features/auth/presentation/views/login_view.dart';
import 'package:ecomerce_market/features/auth/presentation/views/signup/signup_view.dart';
import 'package:ecomerce_market/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:ecomerce_market/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case LogInView.routeName:
      return MaterialPageRoute(builder: (_) => const LogInView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
