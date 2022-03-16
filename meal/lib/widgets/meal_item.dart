import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final Function addFav;
  const MealItem({Key? key, required this.meal, required this.addFav})
      : super(key: key);

  String get _getComplexity {
    switch (meal.complexity) {
      case Complexity.Challenging:
        return 'Challenging';
        // ignore: dead_code
        break;
      case Complexity.Simple:
        return 'Simple';
        // ignore: dead_code
        break;
      case Complexity.Hard:
        return 'Hard';
        // ignore: dead_code
        break;
      default:
        return 'Unknown';
    }
  }

  String get _getAffordability {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        // ignore: dead_code
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        // ignore: dead_code
        break;
      case Affordability.Pricey:
        return 'Pricey';
        // ignore: dead_code
        break;
      default:
        return 'Unknown';
    }
  }

  void _selectedMeal(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MealDetails(
                  meal: meal,
                  addFav: addFav,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        _selectedMeal(context);
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 4.0,
        margin: EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  child: Image.network(
                    meal.imageUrl,
                    height: mediaquery.height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 240,
                    color: Colors.black26,
                    child: Text(
                      meal.title,
                      style: TextStyle(fontSize: 17, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(meal.duration.toString() + 'min'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(_getComplexity),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(_getAffordability),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
