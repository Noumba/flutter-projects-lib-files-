import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/widgets/meal_item.dart';

class Favorite extends StatefulWidget {
  final List<Meal> favorites;
  final Function addFav;
  const Favorite({Key? key, required this.favorites, required this.addFav})
      : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return widget.favorites.isEmpty
        ? Container(
            child: Text('No Favorite'),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.favorites.length,
            itemBuilder: (ctx, index) {
              return MealItem(
                meal: widget.favorites[index],
                addFav: widget.addFav,
              );
            });
  }
}
