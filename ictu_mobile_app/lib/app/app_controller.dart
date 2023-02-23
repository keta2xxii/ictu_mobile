typedef Decoder<T> = T Function(dynamic data);

class AppController {
  AppController._internal();

  static final AppController _singleton = AppController._internal();

  static AppController get instance => _singleton;
}
