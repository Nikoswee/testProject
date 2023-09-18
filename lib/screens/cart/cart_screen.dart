import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cart_bloc.dart';
import '../../bloc/cart_state.dart';
import '../../model/cart.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.items;

          if (cartItems.isEmpty) {
            return Center(child: Text("No items in cart"));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cartItems[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // You would dispatch a RemoveFromCart event or similar, which the BLoC would handle
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // You would dispatch an IncreaseQuantity event or similar, which the BLoC would handle
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          // Confirm order
        },
        child: Text('Confirm Order'),
      ),
    );
  }
}
