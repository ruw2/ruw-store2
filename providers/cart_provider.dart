import 'package:flutter/material.dart';
import 'package:shopping_app/model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> cartList = [];

  // 1. add product to cart
  void addToCart(ProductModel product) {
    cartList.add(product);
    notifyListeners();
  }

  // 2. remove product from cart
  void removeFromCart(ProductModel product) {
    cartList.remove(product);
    notifyListeners();
  }

  // 3. clear cart
  void clearCart() {
    cartList.clear();
    notifyListeners();
  }
}
