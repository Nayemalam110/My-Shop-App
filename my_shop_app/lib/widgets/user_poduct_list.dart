import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/new_product_page.dart';
import 'package:my_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class UserProductList extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  const UserProductList(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: FittedBox(
          child: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title),
        ),
        trailing: Container(
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(NewProductPage.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .removeProduct(id);
              },
              icon: const Icon(Icons.delete),
            ),
          ]),
        ),
      ),
    );
  }
}
