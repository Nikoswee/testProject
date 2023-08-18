import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class PaymentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
              Text('Succesfully paid!'),
              ElevatedButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeScreen()),);
              },
              child: const Text('BACK')
            ),

          ]
        ),
      ),
    );
  }
}