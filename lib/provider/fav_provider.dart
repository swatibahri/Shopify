import 'package:flutter/cupertino.dart';
import 'package:store_app/models/cart_attributes.dart';
import 'package:store_app/models/fav_attributes.dart';

class FavProvider with ChangeNotifier {
  Map<String, FavAttributes> _favItems = {};

  Map<String, FavAttributes> get getFavItems {
    return {..._favItems};
  }

  void addAndRemoveFromFav(String productId, double price, String title, String imageUrl) {
    if (_favItems.containsKey(productId)) {
     removeItem(productId);
    } else {
      _favItems.putIfAbsent(
          productId,
          () => FavAttributes(
              id: DateTime.now().toString(), title: title, price: price, imageUrl: imageUrl));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _favItems.remove(productId);
    notifyListeners();
  }

  void clearFavs() {
    _favItems.clear();
    notifyListeners();
  }
}
