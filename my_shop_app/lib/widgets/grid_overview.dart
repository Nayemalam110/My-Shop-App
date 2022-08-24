import 'package:flutter/material.dart';
import 'package:my_shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class GridOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Products>(context);
    final loadProduct = providerData.loadProduct;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadProduct.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductItem(
            id: loadProduct[index].id,
            imageUrl: loadProduct[index].imageUrl,
            title: loadProduct[index].title);
      },
    );
  }
}
