import '../base/base_socket.dart';
import '../env/environment.dart';

class SocketEvent {
  /*
  * TODO: Define event
  * E.g: static const eventAuthenticate = "authenticate";
  * */
}

class SocketManager extends BaseSocket {
  SocketManager._internal();

  static final SocketManager _singleton = SocketManager._internal();

  static SocketManager get instance => _singleton;

  @override
  String get url => Environment().config.socketUrl;

  @override
  void initEvent() {}

  @override
  void onDispose() {}
}
