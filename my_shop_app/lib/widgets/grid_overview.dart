import 'package:flutter/material.dart';

import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class GridOverview extends StatelessWidget {
  bool showFav;
  GridOverview(this.showFav);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<ProductsProvider>(context);
    final loadProduct =
        showFav ? providerData.favProduct : providerData.loadProduct;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadProduct.length,
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(
          value: loadProduct[index],
          child: ProductItem(),
        );
      },
    );
  }
}
