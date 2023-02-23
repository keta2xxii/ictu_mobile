import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../app/app_config.dart';
import '../env/environment.dart';
import '../app/app_dio_provider.dart';

part 'api_service.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<RestClient> create() async {
    final dio = DioProvider.instance(timeOut: AppConfig.timeOut);
    return RestClient((await dio), baseUrl: Environment().config.baseUrl);
  }
}
