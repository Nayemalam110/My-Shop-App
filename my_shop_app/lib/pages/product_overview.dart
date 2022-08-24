import 'package:flutter/material.dart';
import 'package:my_shop_app/widgets/grid_overview.dart';

class ProductOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'My Shop',
        textAlign: TextAlign.center,
      )),
      body: GridOverview(),
    );
  }
}
