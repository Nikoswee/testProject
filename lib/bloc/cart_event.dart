import '../../model/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final CartItem item;

  const AddToCart(this.item);

  @override
  List<Object> get props => [item];
}

// Add other events like RemoveFromCart, ClearCart, etc. as needed.
