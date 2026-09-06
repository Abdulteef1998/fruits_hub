import 'package:ecomerce_market/core/helper_functions/on_generate_routes.dart';
import 'package:ecomerce_market/core/services/custom_bloc_observer.dart';
import 'package:ecomerce_market/core/services/get_it_services.dart'; // ✅ إضافة ملف GetIt
import 'package:ecomerce_market/core/services/shared_preferences_singleton.dart';
import 'package:ecomerce_market/core/utils/app_colors.dart';
import 'package:ecomerce_market/features/splash/presentation/views/splash_view.dart';
import 'package:ecomerce_market/firebase_options.dart';
import 'package:ecomerce_market/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver(); // 🔥 تعيين CustomBlocObserver
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Prefs.init();

  setupGetIt(); // 🔥 الخطوة الحاسمة لتهيئة GetIt وتسجيل AuthRepo

  runApp(const FruitHub());
}

class FruitHub extends StatelessWidget {
  const FruitHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
