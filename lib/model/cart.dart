import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final double price; // added price field of type double (adjust type if necessary)
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price, // included price in the constructor
    this.quantity = 1,
  });

  CartItem copyWith({
    String? id,
    String? name,
    double? price, // added a price parameter
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price, // included price in the copy
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  CartItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'].toDouble(),
        quantity = json['quantity'];

  static CartItem fromJsonString(String jsonString) {
    return CartItem.fromJson(jsonDecode(jsonString));
  }
}
