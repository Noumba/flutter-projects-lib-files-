import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  final Function addFav;
  const MealDetails({Key? key, required this.meal, required this.addFav})
      : super(key: key);

  Widget _detailsHeading(BuildContext context, String heading) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        heading,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _ingredStepsWidget(Widget child, Size mediaquery) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
        padding: EdgeInsets.all(2.0),
        height: mediaquery.height * 0.25,
        width: double.infinity,
        child: child);
  }

  Widget _ingredientsList(Size mediaquery) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: meal.ingredients.length,
        itemBuilder: (context, index) {
          return Container(
            height: (mediaquery.height * 0.2) / 4,
            child: Card(
              color: Colors.grey.shade800.withOpacity(0.2),
              elevation: 0.0,
              child: Container(
                  padding: EdgeInsets.all(1.0),
                  child: Text(meal.ingredients[index])),
            ),
          );
        });
  }

  Widget _stepsList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: meal.steps.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Center(child: Text('# ' + (index + 1).toString())),
                ),
                title: Text(
                  meal.steps[index],
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black38,
        elevation: 6.0,
        isExtended: true,
        onPressed: () => addFav(meal.id),
        child: Icon(
          Icons.favorite_border_outlined,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: mediaquery.height * 0.3,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _detailsHeading(context, 'Ingredients'),
            _ingredStepsWidget(_ingredientsList(mediaquery), mediaquery),
            _detailsHeading(context, 'Steps'),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _ingredStepsWidget(_stepsList(), mediaquery),
            )
          ],
        ),
      ),
    );
  }
}
