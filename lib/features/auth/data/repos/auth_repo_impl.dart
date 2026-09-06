import 'dart:developer';

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
    String? email,
    String? password,
    String? name,
  }) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );

      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    String? email,
    String? password,
  }) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );

      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}',
      );
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }
}
