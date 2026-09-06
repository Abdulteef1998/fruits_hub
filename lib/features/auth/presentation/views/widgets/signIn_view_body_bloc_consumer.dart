import 'package:ecomerce_market/core/helper_functions/build_error_bar.dart';
import 'package:ecomerce_market/core/widgets/custom_progress_hud.dart';
import 'package:ecomerce_market/features/auth/presentation/views/cubits/cubit/signin_cubit/signin_cubit.dart';
import 'package:ecomerce_market/features/auth/presentation/views/signin_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInViewBodyBlocConsumer extends StatelessWidget {
  const SignInViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          // Handle success state, e.g., navigate to another screen
        } else if (state is SigninFailure) {
          buildErrorBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading,
          child: SigninViewBody(),
        );
      },
    );
  }
}
