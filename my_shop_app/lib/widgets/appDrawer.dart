import 'package:flutter/material.dart';
import '../pages/order_page.dart';
import '../pages/user_product.dart';

class AppDawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Drawer'),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Shop'),
          onTap: (() => Navigator.of(context).pushReplacementNamed('/')),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shopify),
          title: Text('Order'),
          onTap: (() => Navigator.of(context).pushNamed(OrderPage.routeName)),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Products'),
          onTap: (() => Navigator.of(context).pushNamed(UserProduct.routeName)),
        ),
        Divider(),
      ]),
    );
  }
}
