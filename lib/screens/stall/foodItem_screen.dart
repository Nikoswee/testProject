import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  //final List<String> foodItems = ['Chicken Rice', 'Duck Rice', 'Wanton Mee'];
  List<Map<String, dynamic>> foodItems = [];
  final Map<String, List<Map<String, dynamic>>> stallFoodItems = {
    "Ah Heng's Chicken rice" :  [
  {'name': 'Chicken Rice', 'price': 3.50},
  {'name': 'Duck Rice', 'price': 4.00},
  {'name': 'Wanton Mee', 'price': 3.00},
  ],
    "Kim Lee Satay Delight": [
      {'name': 'Nasi Lemak', 'price': 2.50},
      {'name': 'Mee Goreng', 'price': 3.50},
      {'name': 'Teh Tarik', 'price': 1.50},
    ],
    "Poh Kee Hokkien Mee": [
      {'name': 'Laksa', 'price': 4.50},
      {'name': 'Satay', 'price': 0.50},  // Assuming it's price per piece
      {'name': 'Roti Prata', 'price': 1.20},
    ],
    // Add more stalls and their food items as needed
  };

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    foodItems = stallFoodItems[widget.stallName] ?? [];
    readFoodItems(); // Read the stalls immediately when the page loads
  }

  void readFoodItems() async {
    String intro = "Here are the list of available food items in ${widget.stallName}: ";
    String combinedfoodItems = foodItems.map((item) => "${item['name']} for \$${item['price'].toString()}").join(", ");
    await flutterTts.speak(intro + combinedfoodItems);
  }

  void readAddToCart(Map<String, dynamic> food) async {
    await flutterTts.speak("${food['name']} for \$${food['price'].toString()} has been added to the cart.");
  }


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
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: readFoodItems,  // Pressing this button will repeat the stalls reading
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> foodItem = foodItems[index];
          return ListTile(
            title: Text("${foodItem['name']} - \$${foodItem['price'].toString()}"),
            trailing: ElevatedButton(
              onPressed: () {
                var itemId = '${widget.stallName}_$index';
                var item = CartItem(id: itemId, name: foodItem['name'], price: foodItem['price']);
                BlocProvider.of<CartBloc>(context).add(AddToCart(item));
                readAddToCart(foodItem); // Add this line
              },
              child: Text('Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}

