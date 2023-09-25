import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

import 'package:flutter/material.dart';
import '../../model/cart.dart'; // Import the CartItem model
import '../../widgets/widgets.dart';
import '../screens.dart';

@RoutePage()
class PaymentScreen extends StatefulWidget {
  final bool isAuthenticated;
  final List<CartItem> cartItems;  // Add cartItems

  PaymentScreen({
    required this.isAuthenticated,
    required this.cartItems,  // Add cartItems
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: Text('Payment')),
        bottomNavigationBar: CustomNavBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = widget.cartItems[index];
                    return ListTile(
                      title: Text(cartItem.name + " x" + cartItem.quantity.toString()),
                      trailing: Text('\$${cartItem.price * cartItem.quantity}'), // Assuming the price is a double or int, adjust as needed
                    );
                  },
                ),
              ),
              Text('Successfully paid!'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StallsScreen()),
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

