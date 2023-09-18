import 'package:flutter/material.dart';
import '../screens.dart';

class StallsScreen extends StatefulWidget {
  @override
  _StallsScreenState createState() => _StallsScreenState();
}

class _StallsScreenState extends State<StallsScreen> {
  final List<String> stalls = ['Stall A', 'Stall B', 'Stall C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stalls")),
      body: ListView.builder(
        itemCount: stalls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stalls[index]),
            onTap: () {
              // Navigate to food items of the selected stall
              Navigator.push(context, MaterialPageRoute(builder: (context) => FoodItemsScreen(stallName: stalls[index])));
            },
          );
        },
      ),
    );
  }
}

