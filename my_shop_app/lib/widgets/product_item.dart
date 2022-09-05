import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/auth.dart';
import 'package:my_shop_app/providers/cart.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../pages/product_details.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context);
    void productDetailsPage() {
      Navigator.of(context)
          .pushNamed(PoductDetails.routeName, arguments: product.id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              !product.isFavorite ? Icons.favorite_border : Icons.favorite,
              color: IconTheme.of(context).color,
            ),
            onPressed: () {
              product.toggleFavorite(authData.token!);
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text('Added to Cart'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
            icon: Icon(
              Icons.shopping_cart_checkout,
              color: IconTheme.of(context).color,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: productDetailsPage,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
