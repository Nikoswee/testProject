import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
              const Divider(height:50),
              Text('Succesfully paid!'),
                ElevatedButton(
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeScreen()),);
                  },
                  child: const Text('BACK')
                )
          ],
        ),
      ),
    );
  }
}