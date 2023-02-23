import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../app/app_controller.dart';

abstract class BaseSocket {
  late io.Socket socket;

  void onDispose();

  void initEvent();

  String get url;

  void connectSocketIO() async {
    socket = io.io(
        url,
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect(
        (data) => {debugPrint("SocketManager - Connected"), initEvent()});
    socket.onConnectError(
        (data) => {debugPrint("SocketManager - Connect error")});
  }

  void disconnect() {
    socket.disconnect();
    socket.clearListeners();
    onDispose();
  }

  T decoder<T>({dynamic data, required Decoder decoder}) {
    var map = json.decode(data.toString());
    try {
      if (map['data'] != null) {
        map = map['data'];
      }
      return decoder(map);
    } on Exception {
      return decoder(map);
    }
  }
}

class MyStream<T> {
  final _socketResponse = StreamController<T>.broadcast();

  void Function(T) get addResponse => _socketResponse.sink.add;

  Stream<T> get getResponse => _socketResponse.stream;

  void close() => _socketResponse.close();
}
