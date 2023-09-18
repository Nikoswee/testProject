import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart_bloc.dart';
import '../../bloc/cart_event.dart';
import '../../model/cart.dart';
import '../cart/cart_screen.dart';


class FoodItemsScreen extends StatefulWidget {
  final String stallName;

  FoodItemsScreen({required this.stallName});

  @override
  _FoodItemsScreenState createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen> {
  final List<String> foodItems = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stallName),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foodItems[index]),
            trailing: ElevatedButton(
              onPressed: () {
                var item = CartItem(id: 'itemId_$index', name: foodItems[index]);
                BlocProvider.of<CartBloc>(context).add(AddToCart(item));
              },
              child: Text('Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}

