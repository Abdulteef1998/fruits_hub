import 'package:ecomerce_market/core/services/get_it_services.dart';
import 'package:ecomerce_market/core/widgets/custom_app_bar.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:ecomerce_market/features/auth/presentation/views/cubits/cubit/signup_cubit.dart';
import 'package:ecomerce_market/features/auth/presentation/views/signup/widget/signup_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'حساب جديد'),
        body: ModalProgressHUD(
          inAsyncCall: State is SignupLoading ? true : false,
          child: SignupViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
