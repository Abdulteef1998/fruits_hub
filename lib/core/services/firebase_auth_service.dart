import 'dart:developer';

import 'package:ecomerce_market/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}',
      );
      if (e.code == 'weak-password') {
        throw CustomException(message: ' الرقم السري ضعيف جداً.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          message: ' لقد قمت بالتسجيل مسبقًا باستخدام هذا البريد الإلكتروني. ',
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: ' تأكد من اتصالك بالإنترنت وحاول مرة أخرى.  ',
        );
      } else {
        throw CustomException(
          message: e.message ?? '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
        );
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}',
      );
      throw CustomException(
        message: '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}',
      );
      if (e.code == 'user-not-found') {
        throw CustomException(
          message: ' لم يتم العثور على مستخدم بهذا البريد الإلكتروني. ',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: ' كلمة المرور غير صحيحة. ');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          message: ' تأكد من اتصالك بالإنترنت وحاول مرة أخرى.  ',
        );
      } else {
        throw CustomException(
          message: e.message ?? '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
        );
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}',
      );
      throw CustomException(
        message: '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '891928193926-ok1h5kh02r6nn9f28oj3h64a6iardhpm.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return userCredential.user!;
    } on GoogleSignInException catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()} and code is ${e.code}',
      );
      throw CustomException(
        message: '  لقد حدث خطأ ما أثناء تسجيل الدخول بجوجل.  ',
      );
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()} and code is ${e.code}',
      );
      throw CustomException(
        message: e.message ?? '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()}');
      throw CustomException(
        message: '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    }
  }

  Future<User> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    )).user!;
  }

  Future<User> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();

      final UserCredential userCredential;

      if (kIsWeb) {
        userCredential = await FirebaseAuth.instance.signInWithPopup(
          appleProvider,
        );
      } else {
        userCredential = await FirebaseAuth.instance.signInWithProvider(
          appleProvider,
        );
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithApple: ${e.toString()} and code is ${e.code}',
      );
      throw CustomException(
        message: e.message ?? '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithApple: ${e.toString()}');
      throw CustomException(
        message: '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    }
  }
}
