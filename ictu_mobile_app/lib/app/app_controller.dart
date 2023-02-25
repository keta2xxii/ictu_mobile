import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_keys.dart';
import 'package:ictu_mobile_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Decoder<T> = T Function(dynamic data);

class AppController {
  AppController._internal();

  static final AppController _singleton = AppController._internal();

  static AppController get instance => _singleton;
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  ValueNotifier<UserModel> userModel = ValueNotifier(UserModel());

  void clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(AppKeys.keyToken);
    await pref.remove(AppKeys.refreshToken);
  }
}
