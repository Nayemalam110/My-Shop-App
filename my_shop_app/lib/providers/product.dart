import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final num price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavorite(String authToken, String userId) async {
    isFavorite = !isFavorite;

    var url = Uri.parse(
        'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorite/$userId/$id.json?auth=$authToken');
    await http.put(url, body: json.encode(isFavorite));

    notifyListeners();
  }
}
