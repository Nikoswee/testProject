import '../../model/cart.dart';
import 'package:equatable/equatable.dart';

enum CartStatus {
  initial,
  loading,
  success,
  error
}

class CartState extends Equatable {
  final List<CartItem> items;
  final CartStatus status;

  const CartState(this.items, {this.status = CartStatus.initial});

  CartState copyWith({
    List<CartItem>? items,
    CartStatus? status,
  }) {
    return CartState(
      items ?? this.items,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, status];
}

