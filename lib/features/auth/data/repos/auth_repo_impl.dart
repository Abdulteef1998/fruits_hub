import 'package:dartz/dartz.dart';
import 'package:ecomerce_market/core/errors/exceptions.dart';
import 'package:ecomerce_market/core/errors/failure.dart';
import 'package:ecomerce_market/core/services/firebase_auth_service.dart';
import 'package:ecomerce_market/features/auth/data/models/user_model.dart';
import 'package:ecomerce_market/features/auth/domain/entites/user_entity.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImpl({required this.firebaseAuthService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure('An error occurred. Please try again.'));
    }
  }
}
