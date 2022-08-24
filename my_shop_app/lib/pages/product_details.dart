import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class PoductDetails extends StatelessWidget {
  static const routeName = '/product-details';

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)?.settings.arguments as String;

    var loadSingleProduct =
        Provider.of<ProductsProvider>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(title: Text(loadSingleProduct.title)),
    );
  }
}
