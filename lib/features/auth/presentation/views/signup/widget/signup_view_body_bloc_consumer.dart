import 'package:ecomerce_market/core/helper_functions/build_error_bar.dart';
import 'package:ecomerce_market/features/auth/presentation/views/cubits/cubit/signup_cubit.dart';
import 'package:ecomerce_market/features/auth/presentation/views/signup/widget/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء الحساب بنجاح')),
          );
        } else if (state is SignupFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return const SignupViewBody();
      },
    );
  }
}
