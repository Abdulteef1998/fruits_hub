import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/errors/exceptions.dart';
import 'package:ecomerce_market/core/errors/failure.dart';
import 'package:ecomerce_market/core/services/data_service.dart';
import 'package:ecomerce_market/core/services/firebase_auth_service.dart';
import 'package:ecomerce_market/core/services/shared_preferences_singleton.dart';
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
      // تم حذف var حتى يُسند للمتغير الخارجي
      user = await firebaseAuthService.createUserWithEmailAndPassword(
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
      try {
        await firebaseAuthService.deleteUser();
      } catch (e) {
        log('Failed to delete user: ${e.toString()}');
      }
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
      var userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity); // جديد: حفظ محلي

      return right(userEntity);
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
    bool isNewUser = false;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      UserEntity userEntity = UserModel.fromFirebaseUser(user);
      var isUserExists = await databaseService.checkIfDataExists(
        path: BackendEndpoint.isUserExists,
        docuementId: userEntity.uId,
      );
      if (isUserExists) {
        userEntity = await getUserData(uid: user.uid);
      } else {
        isNewUser = true;
        await addUserData(user: userEntity);
      }
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      if (isNewUser) await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      if (isNewUser) await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    bool isNewUser = false;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      UserEntity userEntity = UserModel.fromFirebaseUser(user);
      var isUserExists = await databaseService.checkIfDataExists(
        path: BackendEndpoint.isUserExists,
        docuementId: userEntity.uId,
      );
      if (isUserExists) {
        userEntity = await getUserData(uid: user.uid);
      } else {
        isNewUser = true;
        await addUserData(user: userEntity);
      }
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      if (isNewUser) await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      if (isNewUser) await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}');
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    User? user;
    bool isNewUser = false;
    try {
      user = await firebaseAuthService.signInWithApple();
      UserEntity userEntity = UserModel.fromFirebaseUser(user);
      var isUserExists = await databaseService.checkIfDataExists(
        path: BackendEndpoint.isUserExists,
        docuementId: userEntity.uId,
      );
      if (isUserExists) {
        userEntity = await getUserData(uid: user.uid);
      } else {
        isNewUser = true;
        await addUserData(user: userEntity);
      }
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      if (isNewUser) await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      if (isNewUser) await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithApple: ${e.toString()}');
      return left(ServerFailure('  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  '));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
      path: BackendEndpoint.getUsersData,
      docuementId: uid,
    );
    return UserModel.fromJson(userData);
  }

  // جديد: حفظ بيانات المستخدم محليًا
  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }
}
