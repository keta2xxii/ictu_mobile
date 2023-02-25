import 'base_config.dart';

class DevConfig extends BaseConfig {
  @override
  String get baseUrl => "https://api-dev.ictu.vn:10091/dttx/";

  @override
  // TODO: implement socketUrl
  String get socketUrl => "";
}
