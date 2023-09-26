import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_project/route/app_router.gr.dart';
import 'package:test_project/bloc/speech_bloc/speech_event.dart';
import 'package:test_project/bloc/speech_bloc/speech_state.dart';

import '../../bloc/speech_bloc/speech_bloc.dart';

@RoutePage()
class StallsScreen extends StatefulWidget {
  @override
  _StallsScreenState createState() => _StallsScreenState();
}

class _StallsScreenState extends State<StallsScreen> {
  final List<String> stalls = ["Ah Heng's Chicken rice", "Kim Lee Satay Delight", "Poh Kee Hokkien Mee"];
  final FlutterTts flutterTts = FlutterTts();
  bool stallMatched = false;
  String matchedStallName = '';

  @override
  void initState() {
    super.initState();
    readStalls();
  }

  void readStalls() async {
    String intro = "Here are the list of available stalls: ";
    String combinedStalls = stalls.join(", ");
    Future.delayed(const Duration(milliseconds: 500));
    await flutterTts.speak(intro + combinedStalls);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeechBloc, SpeechState>(
      listener: (context, state) {
        if (state.status == SpeechStatus.receivedSpeech && state.text.isNotEmpty) {
          if (ModalRoute.of(context)!.isCurrent) {
            for (var stall in stalls) {
              print("Comparing ${state.text.trim().toLowerCase()} with ${stall
                  .trim().toLowerCase()}");
              if (stall.trim().toLowerCase().contains(
                 state.text.trim().toLowerCase())) {
                print("Match found with $stall");
                setState(() {
                  stallMatched = true;
                  matchedStallName = stall;
                });
                break;
              }
            }
          }
        }
        // print("bool: $stallMatched");
        // print("matchedStallName: $matchedStallName");
        // print(state.status);
        if (stallMatched && state.status == SpeechStatus.notListening) {
          context.router.push(FoodItemsRoute(stallName: matchedStallName));
          setState(() {
            stallMatched = false;  // reset the value after using it
            matchedStallName = '';
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stalls"),
          actions: [
            IconButton(
              icon: Icon(Icons.repeat),
              onPressed: readStalls,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<SpeechBloc, SpeechState>(
                  builder: (context, state) {
                    return Text("Recognized Text: ${state.text}");
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: stalls.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(stalls[index]),
                      onTap: () {
                        context.router.push(FoodItemsRoute(stallName: stalls[index]));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

