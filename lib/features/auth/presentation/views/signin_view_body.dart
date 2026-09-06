import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/utils/app_colors.dart';
import 'package:ecomerce_market/core/utils/app_images.dart';
import 'package:ecomerce_market/core/utils/app_text_styles.dart';
import 'package:ecomerce_market/core/widgets/custom_button.dart';
import 'package:ecomerce_market/core/widgets/custom_text_form_field.dart';
import 'package:ecomerce_market/core/widgets/password_field.dart';
import 'package:ecomerce_market/features/auth/presentation/views/cubits/cubit/signin_cubit/signin_cubit.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/dont_have_account_widget.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/or_divider.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({Key? key}) : super(key: key);

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  late String email, password;
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'البريد الالكتروني',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              PasswordField(
                onSaved: (value) {
                  password = value!;
                },
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
              CustomButton(onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<SigninCubit>().signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      )
                  ;
                } else {
                  autovalidateMode == AutovalidateMode.always;
                  setState(() {});
                }
              }, text: 'تسجيل الدخول'),

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
