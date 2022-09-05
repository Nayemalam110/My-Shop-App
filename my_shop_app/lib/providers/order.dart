import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  String? authToken;
  String userId;
  Order(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetDataOrder() async {
    final url = Uri.parse(
        'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');

    try {
      final response = await http.get(url);
      final extertData = json.decode(response.body) as Map<String, dynamic>;

      final List<OrderItem> orderdItem = [];

      print('okye 1');
      extertData.forEach(
        (key, value) {
          orderdItem.add(
            OrderItem(
              id: key,
              amount: (value['amount']).toDouble(),
              dateTime: DateTime.parse(value['dateTime']),
              products: (value['products'] as List<dynamic>)
                  .map(
                    (e) => CartItem(
                      id: e['id'],
                      title: e['title'],
                      quantity: e['quantity'],
                      price: e['price'],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
      print('okey 3');

      _orders = orderdItem.reversed.toList();
      notifyListeners();
    } catch (e) {
      print(e);
      print('somethis iis weong');
    }
  }

  Future<void> addOrder(List<CartItem> cartPordut, double total) async {
    var dateData = DateTime.now();

    var url = Uri.parse(
        'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');

    try {
      var response = await http.post(url,
          body: json.encode({
            'dateTime': dateData.toIso8601String(),
            'amount': total,
            'products': cartPordut
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                    })
                .toList(),
          }));
      print(json.decode(response.body)['name']);
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartPordut,
          dateTime: dateData,
        ),
      );
    } catch (e) {
      print('some thing is wrong');
    }

    notifyListeners();
  }
}
