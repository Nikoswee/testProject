import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:local_auth/local_auth.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../bloc/cart_bloc/cart_event.dart';
import '../../bloc/cart_bloc/cart_state.dart';
import '../../bloc/speech_bloc/speech_bloc.dart';
import '../../bloc/speech_bloc/speech_event.dart';
import '../../bloc/speech_bloc/speech_state.dart';
import '../../model/cart.dart';
import '../../route/app_router.gr.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';


@RoutePage()
class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FlutterTts flutterTts = FlutterTts();
  late final LocalAuthentication auth;
  bool payTriggered = false;
  bool confirmTriggered = false;


  @override
  void didChangeDependencies() {
    auth = LocalAuthentication();
    // print("boolean triggerConfirm: ${widget.triggerConfirm}");
    // if (widget.triggerConfirm) {
    //   _authenticate();
    // }
    super.didChangeDependencies();
    final cartItems = context.read<CartBloc>().state.items;
    readCartItems(cartItems);
  }

  void readCartItems(List<CartItem> cartItems) async {
    String intro = "The following items are in your cart: ";
    String combinedItems = cartItems.map((item) => "${item.name}, quantity: ${item.quantity}").join(", ");
    Future.delayed(const Duration(milliseconds: 500));
    await flutterTts.speak(intro + combinedItems);
  }

  double calculateTotal(List<CartItem> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeechBloc, SpeechState>(
        listener: (context, speechState) async {
          if (speechState.status == SpeechStatus.receivedSpeech && speechState.text.isNotEmpty) {
            if (speechState.text.toLowerCase().contains("pay")) {
              setState(() {
                payTriggered = true;
              });
            }
          }

          if (payTriggered && speechState.status == SpeechStatus.notListening){
            final cartItems = context.read<CartBloc>().state.items;
            final total = calculateTotal(cartItems);
            await flutterTts.speak("Your total amount is $total. Please confirm if you'd like to proceed with the payment.");
          }
          if(payTriggered && speechState.status == SpeechStatus.receivedSpeech && speechState.text.isNotEmpty){
            if (speechState.text.toLowerCase().contains("confirm")) {
              setState(() {
                confirmTriggered = true;
              });
            }
          }
          if (payTriggered && confirmTriggered && speechState.status == SpeechStatus.notListening){
            await flutterTts.speak("Please authenticate with either biometric or facial recognition");
            _authenticate();
            setState(() {
              confirmTriggered = false;
              payTriggered = false;
            });
          }
        },
        child: GestureDetector(
        onLongPress: () {
      context.read<SpeechBloc>().add(StartListening());
    },
    onLongPressUp: () {
    context.read<SpeechBloc>().add(StopListening());
    },
    child: Scaffold(
      appBar: AppBar(title: Text("Cart"),
          actions: [
    IconButton(
    icon: Icon(Icons.repeat),
      onPressed: () {  // Add anonymous function here
        final currentCartItems = context.read<CartBloc>().state.items;
        readCartItems(currentCartItems);  // Pass the current cart items
      }, // Pressing this button will repeat the stalls reading
    ),
    ],),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.items;

          if (cartItems.isEmpty) {
            return Center(child: Text("No items in cart"));
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${cartItems[index].name} (Quantity: ${cartItems[index].quantity})"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        var itemToDecrease = cartItems[index];
                        BlocProvider.of<CartBloc>(context).add(DecreaseQuantity(itemToDecrease));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        var itemToIncrease = cartItems[index];
                        BlocProvider.of<CartBloc>(context).add(IncreaseQuantity(itemToIncrease));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          _authenticate();
          // Confirm order
        },
        child: Text('Confirm Order'),
      ),
    ),),
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

        if (authenticated) {
          final cartItems = context.read<CartBloc>().state.items; // Get the cart items
          context.router.push(PaymentRoute(isAuthenticated: true, cartItems: cartItems));
        }

      }
    } on PlatformException catch (e){
      print(e);
    }
  }
}


