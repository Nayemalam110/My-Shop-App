import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/order.dart';
import 'package:my_shop_app/widgets/appDrawer.dart';
import 'package:my_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  static const routeName = '/orders';
  createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    Provider.of<Order>(context, listen: false).fetchAndSetDataOrder();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDawer(),
      body: ListView.builder(
        itemBuilder: ((context, index) => OrderItems(orderData.orders[index])),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
