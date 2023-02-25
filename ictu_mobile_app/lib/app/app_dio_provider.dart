import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:ictu_mobile_app/utils/my_device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_keys.dart';

class DioProvider {
  static Future<dio.Dio> instance({required int timeOut}) async {
    final myDio = dio.Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceId = await MyDeviceInfo().deviceID();
    final token = prefs.getString(AppKeys.keyToken);
    if (token != null) {
      myDio.options.headers = {
        "Accept": "application/json",
        "content-type": "application/json",
        "X-APP-ID": '64c9a192-cc0e-4198-acb8-2188dbb472fa',
        "Authorization": 'Bearer $token',
        "User-Agent": "${Platform.isAndroid ? "iOS" : "Android"}_$deviceId",
      };
    } else {
      myDio.options.headers = {
        "Accept": "application/json",
        "content-type": "application/json",
        "X-APP-ID": '64c9a192-cc0e-4198-acb8-2188dbb472fa',
        "User-Agent": "${Platform.isAndroid ? "iOS" : "Android"}_$deviceId"
      };
    }
    myDio.options.sendTimeout = timeOut;
    myDio.options.connectTimeout = timeOut;
    myDio.options.receiveTimeout = timeOut;
    myDio.interceptors.add(HttpLogInterceptor());
    return myDio;
  }
}

class HttpLogInterceptor extends dio.InterceptorsWrapper {
  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    log("==================================================================================================================\n"
        "onRequest: ${options.uri}\n"
        "data=${options.data}\n"
        "method=${options.method}\n"
        "headers=${options.headers}\n"
        "queryParameters=${options.queryParameters}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    log("onResponse: url:${response.requestOptions.path} : ${response.data}\n"
        "==================================================================================================================");
    super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioError err, dio.ErrorInterceptorHandler handler) {
    log("onError: ${err.requestOptions.path} : $err\n"
        "Response: ${err.requestOptions.path} : ${err.response}\n"
        "==================================================================================================================");
    super.onError(err, handler);
  }
}
