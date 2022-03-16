import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  final List<Meal> availablemeals;
  final Function addFav;
  CategoryMealsScreen({required this.availablemeals, required this.addFav});

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    final id = routeArgs['id'];
    final categoryMeals =
        availablemeals.where((meal) => meal.categories.contains(id)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: categoryMeals[index],
              addFav: addFav,
            );
          }),
    );
  }
}
