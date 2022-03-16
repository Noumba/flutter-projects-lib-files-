import 'package:flutter/material.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:myshop/widgets/order_item.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orderScreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        reverse: true,
        itemBuilder: (context, index) =>
            OrderItems(orderItem: orderData.orders[index]),
        itemCount: orderData.orders.length,
        shrinkWrap: true,
      ),
    );
  }
}
