import 'dart:async';

class BaseFuture<T> {
  final Future<T> _wrappee;

  BaseFuture(Future<T> future) : _wrappee = future;

  BaseFuture<R> then<R>(FutureOr<R> Function(T? value) onValue) =>
      BaseFuture(_wrappee.then<R>(onValue));

  BaseFuture<T> onError<E>(Function onError,
          {bool Function(Object error)? test}) =>
      BaseFuture(_wrappee.catchError(onError, test: test));
}
