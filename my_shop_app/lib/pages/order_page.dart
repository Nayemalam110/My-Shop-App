import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/order.dart';
import 'package:my_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const routeName = '/orders';
  bool orderCountNull = false;

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => OrderItems(orderData.orders[index])),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
