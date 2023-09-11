import 'package:flutter/services.dart';

class FlutterMethodChannel {
  static const channelName = 'yourapp.com/payment'; // this channel name needs to match the one in Native method channel
  late MethodChannel methodChannel;

  static final FlutterMethodChannel instance = FlutterMethodChannel._init();
  FlutterMethodChannel._init();

  void configureChannel() {
    methodChannel = MethodChannel(channelName);
    methodChannel.setMethodCallHandler(this.methodHandler);
  }

  Future<void> methodHandler(MethodCall call) async {
    final String feature = call.arguments;

    switch (call.method) {
      case "receivedFeature": // this method name needs to be the same from invokeMethod in Android
        print("Feature in flutter:" + feature); // you can handle the data here. In this example, we will simply update the view via a data service
        break;
      default:
        print('no method handler for method ${call.method}');
    }
  }
}