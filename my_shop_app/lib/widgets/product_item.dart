import 'package:flutter/material.dart';
import '../pages/product_details.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;

  ProductItem(
      {Key? key, required this.id, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void productDetailsPage() {
      Navigator.of(context)
          .pushNamed(PoductDetails.routeName, arguments: title);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: productDetailsPage,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: IconTheme.of(context).color,
            ),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_checkout,
              color: IconTheme.of(context).color,
            ),
          ),
        ),
      ),
    );
  }
}
