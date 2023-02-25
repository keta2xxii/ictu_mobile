import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ictu_mobile_app/app/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_controller.dart';
import 'app/app_routers.dart';
import 'app/app_themes.dart';
import 'env/environment.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  const String environment = String.fromEnvironment(
    Environment.defineKey,
    defaultValue: Environment.dev,
  );
  Environment().initConfig(environment);
  var accessToken =
      (await SharedPreferences.getInstance()).getString(AppKeys.keyToken) ?? '';
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      child: MyApp(
        root: accessToken.isEmpty ? AppRouter.splash : AppRouter.mainView,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.root = AppRouter.splash,
  });
  final String root;

  @override
  Widget build(BuildContext context) {
    initEasyLoad();
    return MaterialApp(
      scaffoldMessengerKey: AppController.instance.rootScaffoldMessengerKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppThemes.themeData,
      darkTheme: AppThemes.themeData,
      initialRoute: root,
      onGenerateRoute: AppRouter.generateRoute,
      builder: EasyLoading.init(
        builder: (ct, child) => MediaQuery(
          data: MediaQuery.of(ct).copyWith(textScaleFactor: 1),
          child: child!,
        ),
      ),
    );
  }

  void initEasyLoad() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..contentPadding =
          const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.black
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.transparent
      ..boxShadow = const []
      ..indicatorColor = const Color(0xFFFF8100)
      ..textColor = const Color(0xFF12171E)
      ..textStyle = const TextStyle(fontWeight: FontWeight.bold)
      ..textPadding = const EdgeInsets.only(bottom: 10)
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}
