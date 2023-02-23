import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyDeviceInfo {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final String _platform = Platform.isAndroid ? "android" : "ios";

  Future<String> deviceName() async {
    String name = "unknown";
    if (_platform == "android") {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      name = androidInfo.model!;
    } else {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      name = iosInfo.utsname.machine!;
    }
    return name;
  }

  Future<String> deviceID() async {
    String id = "unknown";
    if (_platform == "android") {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      id = androidInfo.androidId!;
    } else {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor!;
    }
    return id;
  }

  Future<String> getVersionApp() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    return version;
  }
}
