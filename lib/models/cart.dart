import 'package:flutter/material.dart';
import 'product.dart';

class CartModel extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();  // 通知所有监听者状态已经改变
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();  // 通知所有监听者状态已经改变
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}
