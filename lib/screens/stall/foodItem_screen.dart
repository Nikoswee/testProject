import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:test_project/bloc/speech_bloc/speech_event.dart';
import 'package:test_project/bloc/speech_bloc/speech_state.dart';
import 'package:test_project/bloc/cart_bloc/cart_bloc.dart';
import 'package:test_project/bloc/cart_bloc/cart_event.dart';
import 'package:test_project/model/cart.dart';
import 'package:auto_route/auto_route.dart';

import '../../bloc/speech_bloc/speech_bloc.dart';
import '../../route/app_router.gr.dart';
import '../cart/cart_screen.dart';

// ... [other necessary imports here] ...

@RoutePage()
class FoodItemsScreen extends StatefulWidget {
  final String stallName;

  FoodItemsScreen({required this.stallName});

  @override
  _FoodItemsScreenState createState() => _FoodItemsScreenState();
}


class _FoodItemsScreenState extends State<FoodItemsScreen> {
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
  bool getItemName = false;
  int quantity = 0;
  Map<String, dynamic>? currentFoodItem;


  @override
  void initState() {
    super.initState();
    foodItems = stallFoodItems[widget.stallName] ?? [];
    readFoodItems(); // Read the stalls immediately when the page loads
  }

  void readFoodItems() async {
    String intro = "Here are the list of available food items in ${widget.stallName}: ";
    String combinedfoodItems = foodItems.map((item) => "${item['name']} for \$${item['price'].toString()}").join(", ");
    Future.delayed(const Duration(milliseconds: 500));
    await flutterTts.speak(intro + combinedfoodItems);
  }

  void readAddToCart(Map<String, dynamic> food) async {
    Future.delayed(const Duration(milliseconds: 300));
    await flutterTts.speak("${food['name']} for \$${food['price'].toString()} has been added to the cart.");
  }

  int extractQuantity(String text) {
    // Use a regular expression to search for any sequences of digits
    final regex = RegExp(r'\d');
    final match = regex.firstMatch(text);

    if (match != null) {
      // Convert the matched string to an integer and return
      return int.parse(match.group(0)!);
    }
    // Return default value if no number found
    return 0;
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeechBloc, SpeechState>(
      listener: (context, state) async {
        print(quantity);
        if (state.status == SpeechStatus.receivedSpeech && state.text.isNotEmpty) {
            for (var foodItem in foodItems) {
              if (foodItem['name'].toLowerCase().contains(state.text.toLowerCase())) {
                setState(() {
                  currentFoodItem = foodItem;
                  getItemName = true;
                });
                break;
              }
            }
          if (state.text.toLowerCase().contains("cart") || state.text.toLowerCase().contains("check out")) {
            context.router.push(CartRoute());
          }
        }
        if (getItemName && state.status == SpeechStatus.notListening){
          await flutterTts.speak("How many ${currentFoodItem?['name']} would you like?");
        }
        if (state.status == SpeechStatus.receivedSpeech && state.text.isNotEmpty){
            quantity = extractQuantity(state.text);
        }
        if (getItemName && quantity > 0 && state.status == SpeechStatus.notListening){
            if (currentFoodItem != null) {
              var itemId = '${widget.stallName}_${foodItems.indexOf(currentFoodItem!)}';
              var item = CartItem(id: itemId, name: currentFoodItem?['name'], price: currentFoodItem?['price'], quantity: quantity);
              BlocProvider.of<CartBloc>(context).add(AddToCart(item));
              flutterTts.speak("${quantity} ${currentFoodItem?['name']} has been added to the cart.");
              setState(() {
                getItemName = false;
                currentFoodItem = null;
              });
            }
        }


      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.stallName),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                context.router.push(CartRoute());
              },
            ),
            IconButton(
              icon: Icon(Icons.repeat),
              onPressed: readFoodItems,
            ),
          ],
        ),
        body: GestureDetector(
          onLongPress: () {
            context.read<SpeechBloc>().add(StartListening());
          },
          onLongPressUp: () {
            context.read<SpeechBloc>().add(StopListening());
          },
          child: ListView.builder(
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
                    readAddToCart(foodItem);
                  },
                  child: Text('Add to Cart'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
