import 'package:flutter/cupertino.dart';

class FavAttributes with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  FavAttributes({this.id, this.title, this.price, this.imageUrl});
}
