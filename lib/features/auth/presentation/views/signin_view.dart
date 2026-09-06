import 'package:ecomerce_market/core/services/get_it_services.dart';
import 'package:ecomerce_market/core/widgets/custom_app_bar.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:ecomerce_market/features/auth/presentation/views/cubits/cubit/signin_cubit/signin_cubit.dart';
import 'package:ecomerce_market/features/auth/presentation/views/widgets/signIn_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SigninCubit(authRepo: getIt.get<AuthRepo>()), // ✅ ضفت authRepo:
      child: Scaffold(
        appBar: buildAppBar(context, title: 'تسجيل دخول'),
        body: SignInViewBodyBlocConsumer(),
      ),
    );
  }
}
