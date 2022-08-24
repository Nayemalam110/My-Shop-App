import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../pages/product_overview.dart';
import '../pages/product_details.dart';

void main() {
  runApp(MyShopApp());
}

class MyShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple, accentColor: Colors.deepOrange),
            fontFamily: 'Lato',
            iconTheme: IconThemeData(color: Colors.red),
            backgroundColor: Colors.amber),
        home: ProductOverview(),
        routes: {
          PoductDetails.routeName: (context) => PoductDetails(),
        },
      ),
    );
  }
}
