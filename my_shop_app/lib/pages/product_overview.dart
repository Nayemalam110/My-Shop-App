import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/cart_page.dart';

import 'package:my_shop_app/providers/cart.dart';

import 'package:my_shop_app/providers/products_provider.dart';
import 'package:my_shop_app/widgets/product_item.dart';
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
  bool isLoading = false;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetData(false)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  Future<void> refresher(context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
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
                const PopupMenuItem(
                  value: FilterOption.Favorite,
                  child: Text("Only Favorite"),
                ),
                const PopupMenuItem(
                  value: FilterOption.All,
                  child: Text('All'),
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
          ],
        ),
        drawer: AppDawer(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () => refresher(context),
                child: GridOverview(showFav)));
  }
}
