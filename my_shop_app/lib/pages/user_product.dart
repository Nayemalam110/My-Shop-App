import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/new_product_page.dart';
import 'package:my_shop_app/pages/splash_screen.dart';
import 'package:my_shop_app/providers/products_provider.dart';
import 'package:my_shop_app/widgets/appDrawer.dart';
import 'package:my_shop_app/widgets/user_poduct_list.dart';
import 'package:provider/provider.dart';

class UserProduct extends StatefulWidget {
  static const routeName = '/user-product';

  @override
  State<UserProduct> createState() => _UserProductState();
}

class _UserProductState extends State<UserProduct> {
  Future<void> refresher(context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetData(false);
  }

  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetData(true)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<ProductsProvider>(
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
  }
}
