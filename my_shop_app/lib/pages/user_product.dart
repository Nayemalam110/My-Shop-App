import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/new_product_page.dart';
import 'package:my_shop_app/providers/products_provider.dart';
import 'package:my_shop_app/widgets/appDrawer.dart';
import 'package:my_shop_app/widgets/user_poduct_list.dart';
import 'package:provider/provider.dart';

class UserProduct extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> refresher(context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetData(true);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: false).fetchAndSetData(true);
    print('running');
    //   var products = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(NewProductPage.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: AppDawer(),
      body: FutureBuilder(
        future: refresher(context),
        initialData: Center(
          child: CircularProgressIndicator(),
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ConnectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () => refresher(context),
                  child: Consumer<ProductsProvider>(
                    builder: ((context, products, _) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) => UserProductList(
                              products.loadProduct[index].id,
                              products.loadProduct[index].title,
                              products.loadProduct[index].imageUrl,
                            ),
                            itemCount: products.loadProduct.length,
                          ),
                        )),
                  ),
                );
        },
      ),
    );
  }
}
