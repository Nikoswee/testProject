import 'package:flutter/material.dart';
import 'widgets/widgets.dart';


void main() {
  runApp(const MyApp());
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.home), 
                onPressed: (){
                  Navigator.pushNamed(context, '/');
                  }),
              IconButton(
                icon: Icon(Icons.shopping_cart), 
                onPressed: (){
                  Navigator.pushNamed(context, '/cart');
                  }),
              IconButton(
                icon: Icon(Icons.person), 
                onPressed: (){
                  Navigator.pushNamed(context, '/user');
                  }),
                  ],
                  ),
                ),
      ),
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
