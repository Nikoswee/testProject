import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../model/cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCart>(_mapAddToCartEventToState);
    // Register other event handlers here...
  }

  void _mapAddToCartEventToState(AddToCart event, Emitter<CartState> emit) {
    try {
      emit(state.copyWith(status: CartStatus.loading)); // Assuming you've added a status field to your state

      List<CartItem> updatedItems = List.from(state.items);
      print("updated item list: $updatedItems");
      var existingIndex = updatedItems.indexWhere((cartItem) => cartItem.id == event.item.id);

      if (existingIndex != -1) {
        var existingItem = updatedItems[existingIndex];
        updatedItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity + 1);
      } else {
        updatedItems.add(event.item);
      }

      emit(state.copyWith(status: CartStatus.success, items: updatedItems));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

// Add other event handling methods as needed
}

