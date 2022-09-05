import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_shop_app/models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _loadProduct = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  String? authToken;
  ProductsProvider(this.authToken, this._loadProduct);

  List<Product> get loadProduct {
    return [..._loadProduct];
  }

  List<Product> get favProduct {
    return _loadProduct.where((element) => element.isFavorite == true).toList();
  }

  Product findById(String id) {
    return loadProduct.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.parse(
        'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final List<Product> loadedProdutData = [];

      final extertData = json.decode(response.body) as Map<String, dynamic>;

      extertData.forEach((key, value) {
        loadedProdutData.add(
          Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: value['isFavorite'],
          ),
        );
      });

      _loadProduct = loadedProdutData;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      print('anything 2');
    }
  }

  Future<void> addProduct(Product prod) async {
    final url = Uri.parse(
        'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken');

    try {
      final value = await http.post(url,
          body: json.encode({
            'title': prod.title,
            'description': prod.description,
            'price': prod.price,
            'imageUrl': prod.imageUrl,
            'isFavorite': prod.isFavorite,
          }));

      final newProduct = Product(
        id: json.decode(value.body)['name'],
        title: prod.title,
        description: prod.description,
        price: prod.price,
        imageUrl: prod.imageUrl,
      );
      _loadProduct.add(newProduct);
      _loadProduct = _loadProduct.reversed.toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeProduct(String id) async {
    var url = Uri.parse(
        'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
    var existingIndex = _loadProduct.indexWhere((element) => element.id == id);
    // _loadProduct.removeWhere((element) => element.id == id);
    Product? existingProduct = _loadProduct[existingIndex];
    _loadProduct.removeAt(existingIndex);
    notifyListeners();

    final resposnse = await http.delete(url);

    if (resposnse.statusCode >= 400) {
      _loadProduct.insert(existingIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }

  Future<void> updateProduct(String id, Product prod) async {
    final podIndex = _loadProduct.indexWhere((element) => element.id == id);
    if (podIndex >= 0) {
      var url = Uri.parse(
          'https://my-shop-49dc7-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken');
      try {
        final value = await http.patch(url,
            body: json.encode({
              'title': prod.title,
              'description': prod.description,
              'price': prod.price,
              'imageUrl': prod.imageUrl,
              'isFavorite': prod.isFavorite,
            }));

        _loadProduct[podIndex] = prod;
      } catch (e) {
        print(e);
      }
    }

    notifyListeners();
  }
}
