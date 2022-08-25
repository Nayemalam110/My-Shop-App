import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/CartItem.dart' as cr;

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Total'),
                  Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}')),
                  Spacer(),
                  TextButton(onPressed: (() {}), child: Text('Order Now'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.item.length,
              itemBuilder: (BuildContext context, int index) {
                var carivli = cart.item.values.toList()[index];
                return cr.CartItem(
                  carivli.id,
                  cart.item.keys.toList()[index],
                  carivli.price,
                  carivli.quantity,
                  carivli.title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
