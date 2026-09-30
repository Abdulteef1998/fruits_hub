import 'package:ecomerce_market/core/services/data_service.dart';
import 'package:ecomerce_market/core/services/firebase_auth_service.dart';
import 'package:ecomerce_market/core/services/firestore_service.dart';
import 'package:ecomerce_market/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ecomerce_market/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
