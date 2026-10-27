import 'dart:convert';

import 'package:ecomerce_market/constant.dart';
import 'package:ecomerce_market/core/errors/exceptions.dart';
import 'package:ecomerce_market/core/services/data_service.dart';
import 'package:ecomerce_market/core/services/firebase_auth_service.dart';
import 'package:ecomerce_market/core/services/shared_preferences_singleton.dart';
import 'package:ecomerce_market/features/auth/data/repos/auth_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockDatabaseService extends Mock implements DatabaseService {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuthService firebaseAuthService;
  late MockDatabaseService databaseService;
  late MockUser firebaseUser;
  late AuthRepoImpl repo;

  setUp(() async {
    // نبدأ بـ SharedPreferences فارغة قبل كل اختبار
    SharedPreferences.setMockInitialValues({});
    await Prefs.init();

    firebaseAuthService = MockFirebaseAuthService();
    databaseService = MockDatabaseService();
    firebaseUser = MockUser();

    when(() => firebaseUser.uid).thenReturn('uid_123');
    when(() => firebaseUser.email).thenReturn('test@test.com');
    when(() => firebaseUser.displayName).thenReturn('Test User');

    repo = AuthRepoImpl(
      firebaseAuthService: firebaseAuthService,
      databaseService: databaseService,
    );
  });

  // بيانات المستخدم كما تُخزَّن في قاعدة البيانات
  // (عدّل المفاتيح إذا كان UserModel.fromJson عندك يستخدم مفاتيح أخرى)
  Map<String, dynamic> storedUserJson() => {
    'uId': 'uid_123',
    'name': 'Test User',
    'email': 'test@test.com',
  };

  void mockAddData() {
    when(
      () => databaseService.addData(
        path: any(named: 'path'),
        data: any(named: 'data'),
        documentId: any(named: 'documentId'),
      ),
    ).thenAnswer((_) async {});
  }

  group('signInWithEmailAndPassword', () {
    test('يحفظ بيانات المستخدم في Prefs بعد تسجيل الدخول', () async {
      when(
        () => firebaseAuthService.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => firebaseUser);

      when(
        () => databaseService.getData(
          path: any(named: 'path'),
          docuementId: any(named: 'docuementId'),
        ),
      ).thenAnswer((_) async => storedUserJson());

      final result = await repo.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: '123456',
      );

      expect(result.isRight(), true);

      final saved = Prefs.getString(kUserData);
      expect(saved, isNotEmpty, reason: 'لم يتم حفظ بيانات المستخدم');

      final decoded = jsonDecode(saved) as Map<String, dynamic>;
      expect(decoded['email'], 'test@test.com');
      expect(decoded['name'], 'Test User');
    });

    test('لا يحفظ شيئًا عند فشل تسجيل الدخول', () async {
      when(
        () => firebaseAuthService.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(CustomException(message: 'كلمة المرور خاطئة'));

      final result = await repo.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'wrong',
      );

      expect(result.isLeft(), true);
      expect(Prefs.getString(kUserData), isEmpty);
    });
  });

  group('signInWithGoogle', () {
    test('مستخدم جديد: يضيف بياناته ويحفظها محليًا', () async {
      when(
        () => firebaseAuthService.signInWithGoogle(),
      ).thenAnswer((_) async => firebaseUser);
      when(
        () => databaseService.checkIfDataExists(
          path: any(named: 'path'),
          docuementId: any(named: 'docuementId'),
        ),
      ).thenAnswer((_) async => false);
      mockAddData();

      final result = await repo.signInWithGoogle();

      expect(result.isRight(), true);
      verify(
        () => databaseService.addData(
          path: any(named: 'path'),
          data: any(named: 'data'),
          documentId: 'uid_123',
        ),
      ).called(1);
      expect(Prefs.getString(kUserData), isNotEmpty);
    });

    test('مستخدم موجود: يجلب بياناته ولا يضيفها من جديد ويحفظها', () async {
      when(
        () => firebaseAuthService.signInWithGoogle(),
      ).thenAnswer((_) async => firebaseUser);
      when(
        () => databaseService.checkIfDataExists(
          path: any(named: 'path'),
          docuementId: any(named: 'docuementId'),
        ),
      ).thenAnswer((_) async => true);
      when(
        () => databaseService.getData(
          path: any(named: 'path'),
          docuementId: any(named: 'docuementId'),
        ),
      ).thenAnswer((_) async => storedUserJson());

      final result = await repo.signInWithGoogle();

      expect(result.isRight(), true);
      verifyNever(
        () => databaseService.addData(
          path: any(named: 'path'),
          data: any(named: 'data'),
          documentId: any(named: 'documentId'),
        ),
      );
      expect(Prefs.getString(kUserData), isNotEmpty);
    });

    test(
      'فشل إضافة البيانات لمستخدم جديد: يحذف الحساب ولا يحفظ شيئًا',
      () async {
        when(
          () => firebaseAuthService.signInWithGoogle(),
        ).thenAnswer((_) async => firebaseUser);
        when(
          () => databaseService.checkIfDataExists(
            path: any(named: 'path'),
            docuementId: any(named: 'docuementId'),
          ),
        ).thenAnswer((_) async => false);
        when(
          () => databaseService.addData(
            path: any(named: 'path'),
            data: any(named: 'data'),
            documentId: any(named: 'documentId'),
          ),
        ).thenThrow(Exception('db error'));
        when(() => firebaseAuthService.deleteUser()).thenAnswer((_) async {});

        final result = await repo.signInWithGoogle();

        expect(result.isLeft(), true);
        verify(() => firebaseAuthService.deleteUser()).called(1);
        expect(Prefs.getString(kUserData), isEmpty);
      },
    );
  });
}
