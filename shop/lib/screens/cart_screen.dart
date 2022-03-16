import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Chip(
                    label: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                      onPressed: () {
                        final orderItem = OrderItem(
                            id: DateTime.now().toString(),
                            amount: cart.totalAmount,
                            products: cart.items.values.toList(),
                            dateTime: DateTime.now());
                        Provider.of<Orders>(context, listen: false)
                            .addOrder(orderItem);
                        cart.clearCart();
                      },
                      child: Text('Make Order'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) => CartItems(
                      id: cart.items.values.toList()[index].id,
                      prodId: cart.items.keys.toList()[index],
                      title: cart.items.values.toList()[index].title,
                      quantity:
                          cart.items.values.toList()[index].quantity.toDouble(),
                      price: cart.items.values.toList()[index].price)))
        ],
      ),
    );
  }
}
