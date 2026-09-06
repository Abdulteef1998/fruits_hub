import 'package:ecomerce_market/core/services/firebase_auth_service.dart';
import 'package:ecomerce_market/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // 1. تسجيل خدمة FirebaseAuthService
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  // 2. تسجيل AuthRepo وتمرير الخدمة لها
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(firebaseAuthService: getIt<FirebaseAuthService>()),
  );
}
