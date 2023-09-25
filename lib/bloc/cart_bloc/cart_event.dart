import '../../../model/cart.dart';
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

class RemoveFromCart extends CartEvent {
  final CartItem item;

  RemoveFromCart(this.item);

  @override
  List<Object> get props => [item];
}

class IncreaseQuantity extends CartEvent {
  final CartItem item;

  IncreaseQuantity(this.item);

  @override
  List<Object> get props => [item];
}

class DecreaseQuantity extends CartEvent {
  final CartItem item;

  DecreaseQuantity(this.item);
  @override
  List<Object> get props => [item];
}



