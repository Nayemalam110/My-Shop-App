import 'package:flutter/material.dart';
import 'package:my_shop_app/pages/order_page.dart';

class AppDawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Drawer'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
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
      ]),
    );
  }
}
