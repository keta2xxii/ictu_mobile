import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_keys.dart';
import 'package:ictu_mobile_app/base/base_schedule.dart';
import 'package:ictu_mobile_app/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/app_controller.dart';
import '../../generated/locale_keys.g.dart';

class HomeViewModel extends BaseSchedule {
  HomeViewModel(BuildContext context) {
    this.context = context;
    getUserProfile();
  }
  UserRepository userRepository = UserRepository();

  void getUserProfile() {
    fetchData(userRepository.getUserProfile(), isLoading: true)
        .then((value) async {
      hideLoading();
      if (value != null) {
        if (value.success) {
          print(value.model!.toJson().toString());
          await (await SharedPreferences.getInstance()).setString(
            AppKeys.userModel,
            jsonEncode(value.model!.toJson()),
          );
          AppController.instance.userModel.value = value.model!;
        } else {
          showError(value.message ?? '');
        }
      } else {
        showError(LocaleKeys.error_title.tr());
      }
    });
  }
}
