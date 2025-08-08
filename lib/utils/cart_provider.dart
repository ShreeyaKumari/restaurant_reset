import 'package:flutter/material.dart';
import 'models.dart';

class CartProvider with ChangeNotifier {
  final Map<Dish, int> _items = {};

  Map<Dish, int> get items => _items;

  void addToCart(Dish dish) {
    if (_items.containsKey(dish)) {
      _items[dish] = _items[dish]! + 1;
    } else {
      _items[dish] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Dish dish) {
    if (_items.containsKey(dish)) {
      _items.remove(dish);
      notifyListeners();
    }
  }

  void increaseQuantity(Dish dish) {
    if (_items.containsKey(dish)) {
      _items[dish] = _items[dish]! + 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Dish dish) {
    if (_items.containsKey(dish)) {
      if (_items[dish]! > 1) {
        _items[dish] = _items[dish]! - 1;
      } else {
        _items.remove(dish); // Remove if quantity becomes 0
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    return _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
