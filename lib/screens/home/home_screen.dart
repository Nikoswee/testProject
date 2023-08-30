import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:test_project/api/method_channel_voice.dart';

import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final MethodChannel _methodChannel = const MethodChannel('com.nikostest.test_project');
  late final LocalAuthentication auth;
  bool _supportState = false;
  String _receivedFeature = 'Listening...';

  @override
  void initState(){
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState((){
    _supportState = isSupported;
    onListenChannel();
    }),
    );

    // _configureMethodChannel();
    // _handleShortcutIntent();

  }

  //   Future<void> _handleMethodCall(MethodCall call) async {
  //   if (call.method == 'receivedFeature') {
  //     String feature = call.arguments;
  //     print("hello im in _handleMethodCall, feature = $feature");
  //     setState(() {
  //       _receivedFeature = feature;
  //     });
  //   }
  // }

  void onListenChannel(){
    _methodChannel.setMethodCallHandler((call) async{
      if (call.method == 'receivedFeature'){
        String feature = call.arguments;

        setState(()=>this._receivedFeature = '$feature');
      }

    });
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
              // const Divider(height:100),
              // ElevatedButton(
              //   onPressed: _handleShortcutIntent,
              //   child: const Text('Handle Intent!')
              // ),
              const Divider(height:100),
              Text('Received Feature: $_receivedFeature'),
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

  //   void _configureMethodChannel() {
  //   const platform = MethodChannel('com.nikostest.test_project');

  //   platform.setMethodCallHandler((call) async {
  //     if (call.method == 'receivedFeature') {
  //       String feature = call.arguments; // The feature value from native code
  //       print("feature in flutter:" + feature);
  //       setState(() {
  //         _receivedFeature = feature; // Update the state with the received feature
  //       });

  //       print(_receivedFeature);
  //     }
  //   });
  // }

  // // Add this method to handle sending the intent to native code
  // Future<void> _handleShortcutIntent() async {
  //   try {
  //     const platform = MethodChannel('com.nikostest.test_project');
  //     await platform.invokeMethod('handleIntent');
  //   } on PlatformException catch (e) {
  //     print("Error: ${e.message}");
  //   }
  // }
}