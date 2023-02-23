import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:sprintf/sprintf.dart';

extension DoubleExtension on double {
  String toCurrency({String? locale}) {
    return NumberFormat("#,##0.00", locale).format(this);
  }

  double roundWithCustomDecimal({int decimal = 0}) {
    return double.parse(toStringAsFixed(decimal));
  }
}

extension StringExtension on String? {
  DateTime stringToDate({String formatString = 'MM-dd-yyyy HH:mm:ss'}) {
    if (this != null) return DateFormat(formatString).parse(this!);
    return DateTime.fromMicrosecondsSinceEpoch(0);
  }

  String formatDate(
      {String formatString = "dd MMM, HH:mm",
      String formatParseDate = 'yyyy-MM-dd HH:mm:ss'}) {
    DateTime date = stringToDate();
    return DateFormat(formatString).format(date);
  }

  bool empty() {
    return this == null || this!.trim().isEmpty;
  }

  bool notEmpty() => !empty();

  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this ?? '');
  }

  bool isPhoneNumber() {
    if (this == null) return false;
    if (this!.length > 16 || this!.length < 9) return false;
    return RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
        .hasMatch(this!);
  }

  String nonAccentVietnamese() {
    String result = this ?? '';
    result =
        result.replaceAll(RegExp(r"à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ"), "a");
    result = result.replaceAll(RegExp(r"è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ"), "e");
    result = result.replaceAll(RegExp(r"ì|í|ị|ỉ|ĩ"), "i");
    result =
        result.replaceAll(RegExp(r"ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ"), "o");
    result = result.replaceAll(RegExp("ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ"), "u");
    result = result.replaceAll(RegExp(r"ỳ|ý|ỵ|ỷ|ỹ"), "y");
    result = result.replaceAll(RegExp(r"đ"), "d");

    result =
        result.replaceAll(RegExp(r"À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ"), "A");
    result = result.replaceAll(RegExp(r"È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ"), "E");
    result = result.replaceAll(RegExp(r"Ì|Í|Ị|Ỉ|Ĩ"), "I");
    result =
        result.replaceAll(RegExp(r"Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ"), "O");
    result = result.replaceAll(RegExp("Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ"), "U");
    result = result.replaceAll(RegExp(r"Ỳ|Ý|Ỵ|Ỷ|Ỹ"), "Y");
    result = result.replaceAll(RegExp(r"Đ"), "D");
    return result;
  }
}

extension NoNullStringExtension on String {
  String format(List<Object> values) {
    return sprintf(this, values);
  }
}

extension DateExtension on DateTime {
  String dateToString({String formatString = "dd MMM, HH:mm a"}) {
    return DateFormat(formatString).format(this);
  }

  DateTime removeMinute() {
    return DateTime(year, month, day, hour);
  }

  DateTime removeTime() {
    return DateTime(year, month, day);
  }
}

extension DurationExtension on Duration {
  String formatHHMMSS() {
    return '$this'.split('.')[0].padLeft(8, '0');
  }

  String formatMMSS() {
    var p = '$this'.split('.')[0].padLeft(8, '0').split(':');
    return "${p[1]}:${p[2]}";
  }
}

extension FutureDelay on num {
  Future delay([FutureOr Function()? callback]) async => Future.delayed(
        Duration(milliseconds: (this * 1000).round()),
        callback,
      );
}
