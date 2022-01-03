import 'package:flutter/material.dart';

class CartAttributes with ChangeNotifier {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartAttributes(
      {this.id,
      @required this.productId,
      this.title,
      this.quantity,
      this.price,
      this.imageUrl});
}