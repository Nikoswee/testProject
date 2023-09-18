import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      home: StallsScreen(),
    );
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
