import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/route/app_router.gr.dart';
import '../cart/cart_screen.dart';
import '../screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../screens.dart';

@RoutePage()
class StallsScreen extends StatefulWidget {
  //
  // final bool triggerConfirm;
  // StallsScreen({this.triggerConfirm = false});

  @override
  _StallsScreenState createState() => _StallsScreenState();
}

class _StallsScreenState extends State<StallsScreen> {

  final List<String> stalls = ["Ah Heng's Chicken rice", "Kim Lee Satay Delight", "Poh Kee Hokkien Mee"];
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    readStalls(); // Read the stalls immediately when the page loads

  }


  void readStalls() async {
    String intro = "Here are the list of available stalls: ";
    String combinedStalls = stalls.join(", ");
    await flutterTts.speak(intro + combinedStalls);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stalls"),
        actions: [
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: readStalls,  // Pressing this button will repeat the stalls reading
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: stalls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stalls[index]),
            onTap: () {
              context.router.push(FoodItemsRoute(stallName: stalls[index]));
              // Navigator.push(context, MaterialPageRoute(builder: (context) => FoodItemsScreen(stallName: stalls[index])));
            },
          );
        },
      ),
    );
  }
}


