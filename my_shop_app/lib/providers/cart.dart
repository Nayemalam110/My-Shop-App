import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final num price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};
  Map<String, CartItem> get item {
    return {..._item};
  }

  int get itemCount {
    return _item.length;
  }

  double get totalAmount {
    var total = 0.00;
    _item.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (!_item.containsKey(productId)) {
      return;
    } else if (_item[productId]!.quantity > 1) {
      _item.update(
          productId,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                quantity: value.quantity - 1,
                price: value.price,
              ));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void addItem(
    String productId,
    num price,
    String title,
  ) {
    if (_item.containsKey(productId)) {
      _item.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            quantity: value.quantity + 1,
            price: value.price),
      );
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }

  void clear() {
    _item = {};
    notifyListeners();
  }
}
