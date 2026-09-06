part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserEntity userEntity;
  SignupSuccess({required this.userEntity});
}

final class SignupFailure extends SignupState {
  final String message; // ✅ التأكد من أنها String وليست num أو dynamic
  SignupFailure({required this.message});
}
