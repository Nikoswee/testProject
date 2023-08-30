import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('com.nikostest.test_project');

Future<void> triggerToast() async {
  try {
    await _channel.invokeMethod('triggerToast');
  } catch (e) {
    print('Error Triggering Toast: $e');
  }
}
