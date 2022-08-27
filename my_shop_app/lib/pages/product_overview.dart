import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/cart_page.dart';
import 'package:my_shop_app/pages/order_page.dart';
import 'package:my_shop_app/providers/cart.dart';

import 'package:my_shop_app/providers/products_provider.dart';
import '../widgets/appDrawer.dart';
import 'package:my_shop_app/widgets/badge.dart';
import 'package:provider/provider.dart';
import '../widgets/grid_overview.dart';

enum FilterOption {
  Favorite,
  All,
}

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool showFav = false;

  @override
  Widget build(BuildContext context) {
    var filterdProducts = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shop',
          textAlign: TextAlign.center,
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption value) {
              setState(() {
                if (value == FilterOption.Favorite) {
                  showFav = true;
                } else {
                  showFav = false;
                }
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("Only Favorite"),
                value: FilterOption.Favorite,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FilterOption.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: ((_, value, ch) =>
                Badge(child: ch!, value: value.itemCount.toString())),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(OrderPage.routeName);
              },
              icon: Icon(Icons.safety_check_outlined))
        ],
      ),
      drawer: AppDawer(),
      body: GridOverview(showFav),
    );
  }
}
