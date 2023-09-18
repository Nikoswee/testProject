import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class PaymentScreen extends StatefulWidget {
  final bool isAuthenticated;
  PaymentScreen({required this.isAuthenticated});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.isAuthenticated) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Payment'),
        bottomNavigationBar: CustomNavBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(height: 50),
              Text('Successfully paid!'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const Text('BACK'),
              ),
            ],
          ),
        ),
      );
    } else {
      // Show an authentication screen or navigate back
      return Scaffold(
        appBar: AppBar(title: Text('Authentication Required')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back when authentication fails
            },
            child: const Text('Go Back'),
          ),
        ),
      );
    }
  }
}
