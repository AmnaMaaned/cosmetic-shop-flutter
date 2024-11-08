import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  int? id;
  String? image;
  String? name;
  int? quantity;
  double? price;
  double? rating;
  String? reviews;
  bool? isFavorite;

  ProductModel({
    this.id,
    this.image,
    this.name,
    this.quantity,
    this.price,
    this.rating,
    this.reviews,
    this.isFavorite,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: data['id'],
      image: data['image'],
      name: data['name'],
      quantity: data['quantity'],
      price: data['price'],
      rating: data['rating'],
      reviews: data['reviews'],
      isFavorite: data['isFavorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'image': image,
      'name': name,
      'quantity': quantity,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'isFavorite': isFavorite,
    };
  }
}
