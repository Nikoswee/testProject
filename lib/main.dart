import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/repo/cart_repo.dart';
import 'bloc/cart_bloc.dart';
import 'screens/screens.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final cartRepository = CartRepository(prefs);

  runApp(
    BlocProvider(
      create: (context) => CartBloc(cartRepository),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Order Application',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Builder(
        builder: (context) => GestureDetector(
          onLongPress: () async {
            if (!_isListening) {
              bool available = await _speech.initialize(onStatus: (status) {
                if (status == "notListening") {
                  setState(() {
                    _isListening = false;
                  });
                }
              });
              if (available) {
                setState(() {
                  _isListening = true;
                });
                _speech.listen(onResult: (result) {
                  print("Recognized Text: ${result.recognizedWords}");
                  // Handle the recognized text here.
                });
                print("Started recording");  // Print message when recording starts
              }
            } else {
              await Future.delayed(Duration(seconds: 1));
              _speech.stop();
              setState(() {
                _isListening = false;
              });
            }
          },
          onLongPressEnd: (details) async {
            if (_isListening) {
              await Future.delayed(Duration(seconds: 1));
              _speech.stop();
              setState(() {
                _isListening = false;
              });
              print("Stopped recording");  // Print message when recording stops
            }
          },
          child: StallsScreen(),
        ),
      ),
    );
  }
}




// class HomeCoordinator extends StatefulWidget {
//   @override
//   _HomeCoordinatorState createState() => _HomeCoordinatorState();
// }
//
// class _HomeCoordinatorState extends State<HomeCoordinator> {
//   static const eventChannel = EventChannel('yourapp.com/events');
//   StreamSubscription? _eventSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _listenToNativeEvents();
//     _checkForPayEvent();
//   }
//
//   void _listenToNativeEvents() {
//     _eventSubscription = eventChannel.receiveBroadcastStream().listen(
//           (event) {
//         if (event == 'pay') {
//           _handlePayEvent();
//         }
//       },
//       onError: (error) {
//         print("Error received: $error");
//       },
//     );
//   }
//   void _checkForPayEvent() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? invokePayEvent = prefs.getBool("invokePayEvent");
//
//     if (invokePayEvent != null && invokePayEvent) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CartScreen(triggerConfirm: true),
//         ),
//       );
//       prefs.setBool("invokePayEvent", false);  // Reset the flag
//     }
//   }
//
//   void _handlePayEvent() async {
//     final prefs = await SharedPreferences.getInstance();
//
//     if (ModalRoute.of(context)?.settings.name == "/cart") {
//       // ... Handle logic if you're already on the CartScreen
//     } else {
//       prefs.setBool("invokePayEvent", true);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CartScreen(triggerConfirm: true),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StallsScreen();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _eventSubscription?.cancel();
//   }
// }







