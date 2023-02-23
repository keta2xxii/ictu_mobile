import 'base_config.dart';
import 'prod_config.dart';
import 'dev_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String defineKey = 'ft_env';
  static const String dev = 'dev';
  static const String prod = 'prod';

  late BaseConfig config;

  void initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.prod:
        return ProdConfig();
      case Environment.dev:
        return DevConfig();
      default:
        return DevConfig();
    }
  }
}
