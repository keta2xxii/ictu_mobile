import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_keys.dart';
import 'package:ictu_mobile_app/base/base_schedule.dart';
import 'package:ictu_mobile_app/repository/authentication_repository.dart';
import 'package:ictu_mobile_app/services/local_authencation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/user_model.dart';

class LoginViewModel extends BaseSchedule {
  LoginViewModel(BuildContext context) {
    this.context = context;
    getData();
  }

  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  LocalAuthService authService = LocalAuthService();

  ValueNotifier<UserModel?> userModel = ValueNotifier(null);

  Future<void> getData() async {
    Map<String, dynamic> json = jsonDecode(
      (await SharedPreferences.getInstance()).getString(AppKeys.userModel) ??
          '',
    );
    print(json);
    if (json.isNotEmpty) {
      userModel.value = UserModel.fromJson(
        json,
      );
    }
    userModel.notifyListeners();
  }

  void login({
    required String username,
    required String password,
    VoidCallback? onSuccess,
  }) {
    fetchData(
      authenticationRepository.login(
        username: userModel.value == null
            ? username
            : userModel.value!.username ?? '',
        password: password,
      ),
      isLoading: true,
    ).then((value) async {
      hideLoading();
      if (value != null) {
        if (value.success) {
          (await SharedPreferences.getInstance())
              .setString(AppKeys.keyToken, value.accessToken ?? '');
          (await SharedPreferences.getInstance())
              .setString(AppKeys.refreshToken, value.refreshToken ?? '');
          (await SharedPreferences.getInstance())
              .setString(AppKeys.password, '$username$password');
          onSuccess?.call();
          showSuccess(value.message ?? '');
        } else {
          showError(value.message ?? '');
        }
      } else {
        showError(LocaleKeys.error_title.tr());
      }
    });
  }

  Future<void> onTapLoginWithFaceID({
    VoidCallback? onSuccess,
  }) async {
    if (userModel.value == null) {
      showError('Vui lòng đăng nhập để có thể sử dụng FaceID');
    } else {
      if (await authService.setUpFaceIdLogin()) {
        String password = (await SharedPreferences.getInstance())
            .getString(AppKeys.password)!
            .split(userModel.value!.username!)
            .last;
        fetchData(
          authenticationRepository.login(
            username: userModel.value!.username ?? '',
            password: password,
          ),
          isLoading: true,
        ).then((value) async {
          hideLoading();
          if (value != null) {
            if (value.success) {
              (await SharedPreferences.getInstance())
                  .setString(AppKeys.keyToken, value.accessToken ?? '');
              (await SharedPreferences.getInstance())
                  .setString(AppKeys.refreshToken, value.refreshToken ?? '');
              onSuccess?.call();
              showSuccess(value.message ?? '');
            } else {
              showError(value.message ?? '');
            }
          } else {
            showError(LocaleKeys.error_title.tr());
          }
        });
      } else {
        showError('Hiện tại không thể đăng nhập bằng FaceID');
      }
    }
  }
}
