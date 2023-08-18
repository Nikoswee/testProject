import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            ElevatedButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>PaymentScreen()),);
              },
              child: const Text('Pay')
            ),
          ]
        ),
      ),
    );
  }
}