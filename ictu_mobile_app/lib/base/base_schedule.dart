import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ictu_mobile_app/app/app_controller.dart';
import 'package:ictu_mobile_app/app/app_styles.dart';
import 'package:ictu_mobile_app/custom_widgets/custom_loading_indicator.dart';
import 'package:ictu_mobile_app/models/error_response.dart';
import 'package:ictu_mobile_app/utils/helpers.dart';

import '../app/app_enums.dart';
import '../app/app_routers.dart';
import '../generated/locale_keys.g.dart';
import '../models/result_model.dart';
import 'base_future.dart';

abstract class BaseSchedule extends ChangeNotifier {
  BaseSchedule();

  late BuildContext context;

  void showError(String message) {
    showSnackBar(message, type: SnackBarType.error);
  }

  void showSuccess(String message) {
    showSnackBar(message, type: SnackBarType.success);
  }

  void showLoading({Widget? indicator}) {
    EasyLoading.show(indicator: indicator ?? const CustomLoadingIndicator());
  }

  void hideLoading() {
    EasyLoading.dismiss();
  }

  void openDialog(
    Widget child, {
    bool barrierDismissible = true,
    VoidCallback? onBack,
  }) {
    showDialog(
      context: context,
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
    ).then((value) => onBack?.call());
  }

  void showSnackBar(String message, {SnackBarType type = SnackBarType.error}) {
    Color color = const Color(0XFFF46666);
    Color bgColor = const Color(0XFFFCD1D1);
    switch (type) {
      case SnackBarType.info:
        color = const Color(0XFF2F80ED);
        bgColor = const Color(0XFFD5E6FB);
        break;
      case SnackBarType.success:
        color = const Color(0XFF2EB872);
        bgColor = const Color(0XFFC2F0D9);
        break;
      case SnackBarType.error:
        color = const Color(0XFFF46666);
        bgColor = const Color(0XFFFCD1D1);
        break;
      case SnackBarType.warning:
        color = const Color(0XFFE6AB3A);
        bgColor = const Color(0XFFFFECC6);
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.info,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: bgColor,
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
    if (!message.contains('Authentication Fail')) {
      AppController.instance.rootScaffoldMessengerKey.currentState
          ?.showSnackBar(snackBar);
    }
  }

  @protected
  void openBottomSheet({required Widget child, Color? bgColor}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bgColor ?? $styles.colors.color33,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => child,
    );
  }

  void checkConnect(
    Object obj,
    Future future, {
    Function(ErrorResponse)? onError,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        handleError(
          obj,
          future,
          onError: onError,
        );
      }
    } on SocketException catch (_) {
      log("The internet connection appears to be offline.");
    }
  }

  void handleError(
    Object obj,
    Future future, {
    Function(ErrorResponse)? onError,
  }) {
    switch (obj.runtimeType) {
      case DioError:
        final res = (obj as DioError).response;
        // final req = res?.realUri;
        if (res != null && res.data != null) {
          Result data = Result.fromJson(res.data);
          final errorRes =
              ErrorResponse(res.statusCode!, data.message!, data.message!);
          switch (errorRes.status) {
            case 500:
              showError(LocaleKeys.error_500.tr());
              break;
            case 401:
              showError(errorRes.message);
              if (!res.realUri.path.contains('/login')) {
                AppController.instance.clearSession();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.login,
                  (route) => false,
                );
              }
              break;
            default:
              onError != null ? onError(errorRes) : showError(errorRes.message);
          }
        }
    }
  }

  @protected
  BaseFuture<T> fetchData<T>(
    Future<T> future, {
    required bool isLoading,
    Function(ErrorResponse)? onError,
  }) {
    if (isLoading) {
      showLoading();
    }
    return BaseFuture<T>(
      future.catchError((obj) {
        debugPrint(
          "${DateTime.now()} - fetchData $T: $obj",
        );
        hideLoading();
        checkConnect(obj, onError: onError, future);
      }),
    );
  }

  @protected
  void showImagePicker(Function(File p1) onCompleted) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Wrap(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  top: 12,
                ),
                child: Text(
                  'Select photo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  color: Colors.black,
                ),
                title: const Text(
                  'Capture from Camera',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Helpers.imgFromCamera().then((value) => {onCompleted(value)});
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Colors.black,
                ),
                title: const Text(
                  'Pick from library',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {
                  Helpers.imgFromGallery()
                      .then((value) => {onCompleted(value)});
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
