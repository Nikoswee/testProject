import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/screens/cart/cart_screen.dart';
import 'bloc/cart_bloc.dart';
import 'screens/screens.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CartBloc(),
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

  void _handlePayEvent() {
    if (ModalRoute.of(context)?.settings.name == "/cart") {
      // If the current screen is CartScreen, just trigger the authentication.
      // ... Your logic here
      // For example, using a global key or a notifier to call _authenticate on the CartScreen.
    } else {
      // Navigate to CartScreen with triggerConfirm set to true.
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







// class MyListView extends StatelessWidget {

//   List<String> dataList = [
//     'Stall 1',
//     'Stall 2',
//     'Stall 3',
//     'Stall 4',
//     'Stall 5',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: dataList.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(dataList[index]),
//           onTap: () {
//             // Add your logic here when an item is tapped.
//             // For example, you can navigate to a new page or perform some action.
//             print('Item ${dataList[index]} is tapped.');
//           },
//         );
//       },
//     );

//   }
// }
