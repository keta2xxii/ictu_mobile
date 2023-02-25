import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/modules/authentication/login_page.dart';
import 'package:ictu_mobile_app/modules/home/home_page.dart';
import 'package:ictu_mobile_app/modules/splash/splash_page.dart';
import 'package:ictu_mobile_app/modules/web_view/web_view_page.dart';

class AppRouter {
  static const String home = "/";
  static const String splash = '/splash';
  static const String login = '/login';
  static const String mainView = '/home';
  static const String webView = '/web_view';

  static Route generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case mainView:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case webView:
        String url = '';
        if (args is String) {
          url = args;
        }
        return MaterialPageRoute(
          builder: (context) => WebViewPage(url: url),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
