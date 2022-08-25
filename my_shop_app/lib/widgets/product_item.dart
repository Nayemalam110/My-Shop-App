import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/cart.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../pages/product_details.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    void productDetailsPage() {
      Navigator.of(context)
          .pushNamed(PoductDetails.routeName, arguments: product.id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: productDetailsPage,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              !product.isFavorite ? Icons.favorite_border : Icons.favorite,
              color: IconTheme.of(context).color,
            ),
            onPressed: () {
              product.toggleFavorite();
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
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
