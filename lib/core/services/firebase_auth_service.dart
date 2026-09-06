import 'dart:developer';

import 'package:ecomerce_market/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}',
      );
      throw CustomException(
        message: '  لقد حدث خطأ ما. يرجى المحاولة مرة أخرى.  ',
      );
    }
  }
}
