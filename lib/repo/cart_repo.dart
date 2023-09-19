import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/cart.dart';

class CartRepository {
  final SharedPreferences _prefs;

  CartRepository(this._prefs);

  Future<void> saveCartItems(List<CartItem> items) async {
    List<Map<String, dynamic>> cartList = items.map((item) => item.toJson()).toList();
    await _prefs.setString('cart', jsonEncode(cartList));
  }

  List<CartItem> loadCartItems() {
    String? storedCart = _prefs.getString('cart');
    if (storedCart == null) return [];
    List<Map<String, dynamic>> cartList = List.from(jsonDecode(storedCart));
    return cartList.map((itemMap) => CartItem.fromJson(itemMap)).toList();
  }
}
