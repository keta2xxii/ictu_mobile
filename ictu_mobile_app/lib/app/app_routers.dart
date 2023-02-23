import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../generated/locale_keys.g.dart';
import '../main.dart';

class AppRouter {
  static const String home = "/";

  static Route generateRoute(RouteSettings settings) {
    // var args = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: LocaleKeys.common_appName.tr(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
