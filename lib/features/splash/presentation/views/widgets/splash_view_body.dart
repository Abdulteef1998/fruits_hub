import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/services/shared_preferences_singleton.dart';
import 'package:ecomerce_market/core/utils/app_images.dart';
import 'package:ecomerce_market/features/auth/presentation/views/login_view.dart';
import 'package:ecomerce_market/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [SvgPicture.asset(Assets.imagesPlant, height: 173)],
        ),
        SvgPicture.asset(Assets.imagesLogo, height: 173),
        SvgPicture.asset(
          Assets.imagesSplashButtion,
          fit: BoxFit.fill,
          height: 158,
        ),
      ],
    );
  }

  void executeNavigation() {
    bool isOnBoardingViewSeen = Prefs.getBool(KIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 3), () {
      if (isOnBoardingViewSeen) {
        Navigator.pushReplacementNamed(context, LogInView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
