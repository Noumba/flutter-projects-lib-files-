import 'package:flutter/material.dart';
import 'package:mealapp/dummy_data.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/category_meals_screen.dart';
import 'package:mealapp/screens/filter_screen.dart';
import 'package:mealapp/screens/tab_bar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'lactose': false,
    'gluten': false,
    'vegan': false,
    'vegeterian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _isFavorited(String mealId) {
    var selectedFav = _favorites.indexWhere((meal) => meal.id == mealId);
    if (selectedFav >= 0) {
      setState(() {
        _favorites.removeAt(selectedFav);
      });
    } else {
      setState(() {
        _favorites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _ismealFav(String id) {
    return _favorites.any((element) => element.id == id);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
          textTheme: TextTheme().copyWith(
              bodyText1: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.w600)),
          primarySwatch: Colors.pink,
          fontFamily: 'Raleway',
          accentColor: Colors.amber,
          canvasColor: Colors.grey.shade100.withOpacity(1),
          appBarTheme: AppBarTheme(color: Colors.grey.shade700.withOpacity(1))),
      home: TabScreen(
        favorites: _favorites,
        addFav: _isFavorited,
      ),
      routes: {
        '/Category_meals': (ctx) => CategoryMealsScreen(
            availablemeals: _availableMeals, addFav: _isFavorited),
        '/Filter_screen': (ctx) => FilterScreen(
              saveFilter: _setFilters,
              currentFilters: _filters,
              favorites: _favorites,
              addFav: _isFavorited,
            ),
      },
    );
  }
}
