import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/services/shared_preferences_singleton.dart';
import 'package:ecomerce_market/core/utils/app_colors.dart';
import 'package:ecomerce_market/core/widgets/custom_button.dart';
import 'package:ecomerce_market/features/auth/presentation/views/login_view.dart';
import 'package:ecomerce_market/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';
import 'package:flutter/material.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnBoardingPageView(pageController: pageController)),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            color: currentPage == 1
                ? AppColors.primaryColor
                : AppColors.primaryColor.withOpacity(.5),
            activeColor: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 29),
        Visibility(
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          visible: currentPage == 1 ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
            child: CustomButton(
              onPress: () {
                Prefs.setBool(KIsOnBoardingViewSeen, true);
                Navigator.of(context).pushReplacementNamed(LogInView.routeName);
              },
              text: 'ابدأ الان',
            ),
          ),
        ),
        SizedBox(height: 43),
      ],
    );
  }
}
