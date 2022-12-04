import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  int price;
  String ratings;
  String deliveryTime;
  String image;
  bool isFavourite;
  int quantity;

  Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.ratings,
      required this.deliveryTime,
      required this.image,
      required this.isFavourite,
      this.quantity = 0});
}
