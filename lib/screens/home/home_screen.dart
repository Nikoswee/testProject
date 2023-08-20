import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState(){
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState((){
      _supportState = isSupported;
    }),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
                if(_supportState) 
                  const Text('This device is supported')
                else 
                  const Text('This device is not supported'),
                
              const Divider(height: 100),
              ElevatedButton(
                onPressed: _getAvailableBiometrics,
                child: const Text("Get Available Biometrics"),
              ),
              const Divider(height:100),
              ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Pay')
              ),
          ]
        ),
      ),
    );
  }

  Future<void> _authenticate() async{
    try{
      List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.strong)){
        bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate with facial recognition',
        options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
        ),
      );
    print("Authenticated: $authenticated");

    if (authenticated){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen(isAuthenticated: true,)));
    }
    }
    } on PlatformException catch (e){
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async{
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    print("List of available Biometrics: $availableBiometrics");

    if(!mounted){
      return;
    }
  }
}