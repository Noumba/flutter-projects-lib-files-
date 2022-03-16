import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String prodId;
  final double price;
  final double quantity;
  final String title;
  const CartItems(
      {Key? key,
      required this.id,
      required this.prodId,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white70,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove item from cart?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        'NO',
                        textAlign: TextAlign.end,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'YES',
                          textAlign: TextAlign.end,
                        ))
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(prodId);
        print('Cart Item ' + prodId + ' removed from cart');
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: FittedBox(child: Text('\$$price')),
                ),
              ),
              title: Text(title),
              subtitle: Text('\$${quantity * price}'),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [],
                icon: Icon(Icons.more_vert),
              )),
        ),
      ),
    );
  }
}
