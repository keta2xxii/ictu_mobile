import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_model.g.dart';

typedef Decoder<T> = T Function(dynamic data);

class BaseDecoder<T> {
  final Result result;
  final Decoder? decoder;

  BaseDecoder(this.result, {this.decoder});
  T? get model => decoded<T>();

  T? decoded<C>() {
    T? body;
    try {
      if (result.data != null && decoder != null) {
        body = decoder!(result.data);
      } else {
        if (kDebugMode) {
          log(
            "BaseDecoder => ${T.toString()}",
            name: "data or decorder is not exist",
          );
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) log("BaseDecoder => ${T.toString()}", name: e.toString());
    }
    return body;
  }

  bool get success => result.code == 'success';
  String get devMessage => result.developerMessage ?? "";
  dynamic get message => result.message;
}

@JsonSerializable()
class Result {
  dynamic data;
  final String? message;
  final dynamic code;
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  final String? developerMessage;

  Result({
    this.data,
    required this.code,
    this.developerMessage,
    this.message,
    this.accessToken,
    this.refreshToken,
  });

  bool get success => code == 'success';

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
