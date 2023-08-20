import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('com.nikostest.test_project/payment');

Future<void> navigateToPaymentScreen() async {
  try {
    await _channel.invokeMethod('navigateToPayment');
  } catch (e) {
    print('Error navigating to PaymentScreen: $e');
  }
}
