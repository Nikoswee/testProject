class CartItem {
  final String id;
  final String name;
  int quantity;

  CartItem({required this.id, required this.name, this.quantity = 1});


  CartItem copyWith({String? id, String? name, int? quantity}) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}

