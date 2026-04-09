import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/utils/app_colors.dart';
import 'package:ecomerce_market/core/utils/app_images.dart';
import 'package:ecomerce_market/core/utils/app_text_styles.dart';
import 'package:ecomerce_market/core/widgets/custom_button.dart';
import 'package:ecomerce_market/core/widgets/custom_text_form_field.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/dont_have_account_widget.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/or_divider.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/social_login_button.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(
                hintText: 'البريد الالكتروني',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'كلمة المرور',
                textInputType: TextInputType.visiblePassword,
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xffC9CECF),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'نسيت كلمة المرور؟',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 33),
              CustomButton(onPress: () {}, text: 'تسجيل الدخول'),

              SizedBox(height: 16),
              DontHaveAnAccountWidget(),
              SizedBox(height: 16),
              OrDivider(),
              SocialLoginButton(
                title: 'تسجيل الدخول  بواسطة جوجل',
                image: Assets.imagesGoogleIcon,
                onPressed: () {},
              ),
              SizedBox(height: 16),
              SocialLoginButton(
                title: 'تسجيل الدخول  بواسطة أبل',
                image: Assets.imagesApplIcon,
                onPressed: () {},
              ),
              SizedBox(height: 16),
              SocialLoginButton(
                title: 'تسجيل الدخول  بواسطة فيسبوك',
                image: Assets.imagesFacebookIcon,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
