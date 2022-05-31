@JS('window')
library ethereum;

import 'package:js/js.dart';

@JS('ethereum')
external Ethereum get ethereum;

/// await promiseToFuture(ethereum.request(RequestParams(method: 'eth_requestAccounts')));

@JS()
class Ethereum {
  @JS('chainId')
  external String chainId();

  @JS('isConnected')
  external bool isConnected();

  @JS('selectedAddress')
  external String get selectedAddress;

  @JS('request')
  external Future request(RequestParams params);
}

@JS()
@anonymous
class RequestParams {
  external String get method;

  external dynamic get params;

  external factory RequestParams({String? method, dynamic params});
}
