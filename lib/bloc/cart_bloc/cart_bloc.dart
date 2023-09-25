import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repo/cart_repo.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../../model/cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;

  CartBloc(this._repository) : super(CartState(_repository.loadCartItems())) {
    on<AddToCart>(_mapAddToCartEventToState);
    on<RemoveFromCart>(_mapRemoveFromCartEventToState);
    on<IncreaseQuantity>(_mapIncreaseQuantityEventToState);
    on<DecreaseQuantity>(_mapDecreaseQuantityEventToState);
    // Register other event handlers here...
  }

  void _mapAddToCartEventToState(AddToCart event, Emitter<CartState> emit) {
    try {
      emit(state.copyWith(status: CartStatus
          .loading)); // Assuming you've added a status field to your state

      List<CartItem> updatedItems = List.from(state.items);
      print("updated item list: $updatedItems");
      var existingIndex = updatedItems.indexWhere((cartItem) =>
      cartItem.id == event.item.id);

      if (existingIndex != -1) {
        var existingItem = updatedItems[existingIndex];
        updatedItems[existingIndex] =
            existingItem.copyWith(quantity: existingItem.quantity + 1);
      } else {
        updatedItems.add(event.item);
      }
      _repository.saveCartItems(updatedItems);
      emit(state.copyWith(status: CartStatus.success, items: updatedItems));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  void _mapRemoveFromCartEventToState(RemoveFromCart event,
      Emitter<CartState> emit) {
    try {
      emit(state.copyWith(status: CartStatus.loading));

      List<CartItem> updatedItems = List.from(state.items);
      updatedItems.removeWhere((cartItem) => cartItem.id == event.item.id);
      _repository.saveCartItems(updatedItems);
      emit(state.copyWith(status: CartStatus.success, items: updatedItems));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  void _mapIncreaseQuantityEventToState(IncreaseQuantity event,
      Emitter<CartState> emit) {
    try {
      emit(state.copyWith(status: CartStatus.loading));

      List<CartItem> updatedItems = List.from(state.items);
      var existingIndex = updatedItems.indexWhere((cartItem) =>
      cartItem.id == event.item.id);

      if (existingIndex != -1) {
        var existingItem = updatedItems[existingIndex];
        updatedItems[existingIndex] =
            existingItem.copyWith(quantity: existingItem.quantity + 1);
      }
      _repository.saveCartItems(updatedItems);
      emit(state.copyWith(status: CartStatus.success, items: updatedItems));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  void _mapDecreaseQuantityEventToState(DecreaseQuantity event,
      Emitter<CartState> emit) {
    try {
      emit(state.copyWith(status: CartStatus.loading));

      List<CartItem> updatedItems = List.from(state.items);
      var existingIndex = updatedItems.indexWhere((cartItem) =>
      cartItem.id == event.item.id);

      if (existingIndex != -1) {
        var existingItem = updatedItems[existingIndex];
        // Check if quantity is more than 1
        if (existingItem.quantity > 1) {
          updatedItems[existingIndex] =
              existingItem.copyWith(quantity: existingItem.quantity - 1);
        } else {
          // If the quantity is 1, remove the item from the cart
          updatedItems.removeAt(existingIndex);
        }
      }
      _repository.saveCartItems(updatedItems);
      emit(state.copyWith(status: CartStatus.success, items: updatedItems));
    } catch (error) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

}

