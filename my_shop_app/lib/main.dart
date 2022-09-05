import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/auth_screen.dart';

import 'package:my_shop_app/pages/cart_page.dart';
import 'package:my_shop_app/pages/new_product_page.dart';
import 'package:my_shop_app/pages/order_page.dart';
import 'package:my_shop_app/pages/user_product.dart';
import 'package:my_shop_app/providers/auth.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:my_shop_app/providers/order.dart';
import 'package:provider/provider.dart';
import 'providers/products_provider.dart';
import '../pages/product_overview.dart';
import '../pages/product_details.dart';

void main() {
  runApp(MyShopApp());
}

class MyShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            create: (context) => ProductsProvider('', '', []),
            update: (context, value, previous) => ProductsProvider(value.token,
                value.usreId, previous == null ? [] : previous.loadProduct),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Order>(
            create: (context) => Order('', '', []),
            update: (context, value, previous) {
              return Order(value.token, value.usreId!,
                  previous == null ? [] : previous.orders);
            },
          )
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.purple,
                    accentColor: Colors.deepOrange),
                fontFamily: 'Lato',
                iconTheme: IconThemeData(color: Colors.orange.shade900),
                backgroundColor: Colors.amber),
            home: auth.IsAuth ? ProductOverview() : AuthScreen(),
            routes: {
              PoductDetails.routeName: (context) => PoductDetails(),
              CartPage.routeName: (context) => CartPage(),
              OrderPage.routeName: (context) => OrderPage(),
              UserProduct.routeName: (context) => UserProduct(),
              NewProductPage.routeName: (context) => NewProductPage(),
            },
          ),
        ));
  }
}
