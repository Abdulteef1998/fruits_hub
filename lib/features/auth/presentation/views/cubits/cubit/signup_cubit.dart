import 'package:bloc/bloc.dart';
import 'package:ecomerce_market/features/auth/domain/entites/user_entity.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignupLoading());

    final result = await authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );

    result.fold(
      (failure) => emit(SignupFailure(message: failure.message)),
      (userEntity) => emit(SignupSuccess(userEntity: userEntity)),
    );
  }
}
