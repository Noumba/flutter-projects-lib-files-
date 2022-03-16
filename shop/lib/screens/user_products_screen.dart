import 'package:flutter/material.dart';

import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:myshop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/userProductScreen';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Productsproviders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (context, index) => Column(
                  children: [
                    UserProductItem(
                      title: productData.items[index].title,
                      imageUrl: productData.items[index].url,
                      prodIdl: productData.items[index].id,
                    ),
                    Divider()
                  ],
                )),
      ),
    );
  }
}
