import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/widgets/custom_button.dart';
import 'package:ecomerce_market/core/widgets/custom_text_form_field.dart';
import 'package:ecomerce_market/features/auth/presentation/views/signup/widget/lib/features/auth/presentation/views/widgets/terms_and_conditions.dart';
import 'package:ecomerce_market/features/splash/presentation/views/widgets/have_an_account_widget.dart';
import 'package:flutter/material.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextFormField(
              hintText: 'الاسم الكامل',
              textInputType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'البريد الإلكتروني',
              textInputType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'كلمة المرور',
              textInputType: TextInputType.visiblePassword,
              suffixIcon: Icon(Icons.remove_red_eye, color: Color(0xffC9CECF)),
            ),
            const SizedBox(height: 16),
            TermsAndConditionsWidget(
              onChanged: (value) {
                // Handle terms and conditions change
              },
            ),
            const SizedBox(height: 30),
            CustomButton(onPress: () {}, text: 'انشاء حساب جديد'),
            SizedBox(height: 26),
            HaveAnAccountWidget(),
          ],
        ),
      ),
    );
  }
}
