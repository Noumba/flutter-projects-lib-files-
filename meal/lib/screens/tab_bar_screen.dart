import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/category_screen.dart';
import 'package:mealapp/screens/favorite_screen.dart';
import 'package:mealapp/screens/drawer_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key, required this.favorites, required this.addFav})
      : super(key: key);
  final List<Meal> favorites;
  final Function addFav;

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, dynamic>> _pages = [{}];

  int _selectedIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'title': 'Category', 'page': Categories()},
      {
        'title': 'Favorites',
        'page': Favorite(
          favorites: widget.favorites,
          addFav: widget.addFav,
        )
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
        elevation: 0.0,
        centerTitle: false,
      ),
      drawer: DrawerScreen(
        favorites: widget.favorites,
        addFav: widget.addFav,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        onTap: (index) {
          _selectedTab(index);
        },
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              icon: Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              icon: Icon(Icons.favorite),
              label: 'Favorites')
        ],
        currentIndex: _selectedIndex,
      ),
      body: _pages[_selectedIndex]['page'],
    );
  }
}
