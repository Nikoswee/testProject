import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/repo/cart_repo.dart';
import 'package:test_project/screens/cart/cart_screen.dart';
import 'bloc/cart_bloc.dart';
import 'screens/screens.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Order Application',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomeCoordinator(), // Use a coordinator for centralized event handling.
    );
  }
}

class HomeCoordinator extends StatefulWidget {
  @override
  _HomeCoordinatorState createState() => _HomeCoordinatorState();
}

class _HomeCoordinatorState extends State<HomeCoordinator> {
  static const eventChannel = EventChannel('yourapp.com/events');
  StreamSubscription? _eventSubscription;

  @override
  void initState() {
    super.initState();
    _listenToNativeEvents();
    _checkForPayEvent();
  }

  void _listenToNativeEvents() {
    _eventSubscription = eventChannel.receiveBroadcastStream().listen(
          (event) {
        if (event == 'pay') {
          _handlePayEvent();
        }
      },
      onError: (error) {
        print("Error received: $error");
      },
    );
  }
  void _checkForPayEvent() async {
    final prefs = await SharedPreferences.getInstance();
    bool? invokePayEvent = prefs.getBool("invokePayEvent");

    if (invokePayEvent != null && invokePayEvent) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(triggerConfirm: true),
        ),
      );
      prefs.setBool("invokePayEvent", false);  // Reset the flag
    }
  }

  void _handlePayEvent() async {
    final prefs = await SharedPreferences.getInstance();

    if (ModalRoute.of(context)?.settings.name == "/cart") {
      // ... Handle logic if you're already on the CartScreen
    } else {
      prefs.setBool("invokePayEvent", true);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(triggerConfirm: true),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StallsScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _eventSubscription?.cancel();
  }
}







