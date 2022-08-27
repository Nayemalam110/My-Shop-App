import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/order.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItems extends StatefulWidget {
  final OrderItem order;
  OrderItems(this.order);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _expended = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.order.amount}"),
            subtitle: Text(
                DateFormat('dd/mm/yyyy E hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expended ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expended = !_expended;
                });
              },
            ),
          ),
          if (_expended)
            Container(
              padding: EdgeInsets.all(10),
              height: min(widget.order.products.length * 20.0 + 20, 200),
              child: ListView(
                children: widget.order.products.map((e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.title),
                      Text("${e.quantity}x \$${e.price}")
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
