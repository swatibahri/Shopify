import 'package:flutter/cupertino.dart';
import 'package:store_app/models/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttributes> _cartItems = {};

  Map<String, CartAttributes> get getCartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(String productId, double price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartAttributes(
              id: exitingCartItem.id,
              productId: exitingCartItem.productId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity + 1,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartAttributes(
              id: DateTime.now().toString(),
              productId: productId,
              title: title,
              price: price,
              quantity: 1,
              imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void reduceItemByOne(
    String productId,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartAttributes(
              id: exitingCartItem.id,
              productId: exitingCartItem.productId,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity - 1,
              imageUrl: exitingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
