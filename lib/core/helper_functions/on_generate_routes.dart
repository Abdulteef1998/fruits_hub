import 'package:ecomerce_market/features/auth/presentation/views/signin_view.dart';
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
    case SigninView.routeName:
      return MaterialPageRoute(builder: (_) => const SigninView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
