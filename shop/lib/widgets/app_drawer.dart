import 'package:flutter/material.dart';
import 'package:myshop/screens/order_screen.dart';
import 'package:myshop/screens/product_overview_screens.dart';
import 'package:myshop/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop_2),
            title: Text('Shop'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ProductsOverviewScreen()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket_outlined),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text('Manage products'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, UserProductScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
