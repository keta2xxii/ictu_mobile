import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ictu_mobile_app/app/app_enums.dart';
import 'package:ictu_mobile_app/generated/locale_keys.g.dart';

import '../models/error_response.dart';
import '../utils/helpers.dart';
import 'base_future.dart';

abstract class BaseSchedule extends ChangeNotifier {
  BaseSchedule();

  late BuildContext context;

  @protected
  void showError(String message, {VoidCallback? onPress, String? title}) {
    title ??= LocaleKeys.error_title.tr();
    FocusScope.of(context).requestFocus(FocusNode());
    showSnackBar(message, type: SnackBarType.error);
  }

  @protected
  void showSuccess(String message, {String? title, VoidCallback? onPress}) {
    title ??= LocaleKeys.success_title.tr();
    FocusScope.of(context).requestFocus(FocusNode());
    //TODO.showSuccess
  }

  void showLoading() {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
      context: context,
      builder: (context) => Material(
        color: Colors.black26,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    Navigator.of(context).pop();
  }

  void openDialog(
    Widget child, {
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
    );
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
          Text(
            message,
            style: TextStyle(
              color: color,
              fontFamily: 'iCielHelveticaNowText',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      backgroundColor: bgColor,
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
    if (!message.contains('Authentication Fail')) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void checkConnect(Object obj, {Function(ErrorResponse)? onError}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        handleError(obj, onError: onError);
      }
    } on SocketException catch (_) {
      log("The internet connection appears to be offline.");
    }
  }

  void handleError(Object obj, {Function(ErrorResponse)? onError}) {
    switch (obj.runtimeType) {
      case DioError:
        final res = (obj as DioError).response;
        // final req = res?.realUri;
        if (res != null && res.data != null) {
          Map<String, dynamic> data = jsonDecode(res.data.toString());
          final errorRes = ErrorResponse.fromJson(data);
          switch (errorRes.status) {
            case 500:
              showError(LocaleKeys.error_500);
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
        checkConnect(obj, onError: onError);
      }),
    );
  }

  void showImagePicker(Function(File p1) onCompleted) {
    showBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Wrap(
            children: <Widget>[
              const Text('Select photo'),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  color: Colors.black,
                ),
                title: const Text('Capture from Camera'),
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
                title: const Text('Pick from library'),
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
