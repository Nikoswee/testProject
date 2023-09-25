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
import '../../model/cart.dart';
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


  @override
  void didChangeDependencies() {
    // auth = LocalAuthentication();
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
    await flutterTts.speak(intro + combinedItems);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(isAuthenticated: true, cartItems: cartItems),
            ),
          );
        }

      }
    } on PlatformException catch (e){
      print(e);
    }
  }
}


