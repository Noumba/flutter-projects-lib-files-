import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:myshop/screens/cart_screen.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:myshop/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';

enum filterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Productsproviders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('MySHop'),
        actions: [
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                },
                icon: Icon(Icons.shopping_cart_outlined)),
            builder: (_, cart, ch) => Badge(
                child: ch!,
                value: cart.itemCount.toString(),
                color: Colors.blue),
          ),
          PopupMenuButton(
              onSelected: (filterOptions selectedValue) {
                if (selectedValue == filterOptions.Favorites) {
                  setState(() {
                    _showOnlyFavorites = true;
                  });
                } else {
                  setState(() {
                    _showOnlyFavorites = false;
                  });
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: filterOptions.All,
                    ),
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: filterOptions.Favorites,
                    )
                  ])
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: ProductsGrid(
          showOnlyFavorites: _showOnlyFavorites,
        ),
      ),
    );
  }
}
