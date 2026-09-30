import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecomerce_market/core/errors/exceptions.dart';
import 'package:ecomerce_market/core/errors/failure.dart';
import 'package:ecomerce_market/core/services/data_service.dart';
import 'package:ecomerce_market/core/services/firebase_auth_service.dart';
import 'package:ecomerce_market/core/utils/backend_endpoint.dart';
import 'package:ecomerce_market/features/auth/data/models/user_model.dart';
import 'package:ecomerce_market/features/auth/domain/entites/user_entity.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.firebaseAuthService,
    required this.databaseService,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    String? email,
    String? password,
    String? name,
  }) async {
    User? user;
    try {
      var user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email ?? '',
        password: password ?? '',
      );
      var userEntity = UserEntity(
        uId: user.uid,
        name: name ?? '',
        email: email ?? '',
      );
      await addUserData(user: userEntity);

      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
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

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      var user = await firebaseAuthService.signInWithGoogle();
      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      var user = await firebaseAuthService.signInWithFacebook();

      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}');
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    User? user;
    try {
      var user = await firebaseAuthService.signInWithApple();
      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithApple: ${e.toString()}');
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: user.toMap(),
      documentId: user.uId,
    );
  }
}
