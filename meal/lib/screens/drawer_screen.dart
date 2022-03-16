import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/tab_bar_screen.dart';

class DrawerScreen extends StatelessWidget {
  final List<Meal> favorites;
  final Function addFav;
  const DrawerScreen({Key? key, required this.favorites, required this.addFav})
      : super(key: key);

  Widget _buildListTile(IconData icon, String title, tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(title),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 120,
                width: double.infinity,
                color: Theme.of(context).accentColor,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cooking Up!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoCondensed'),
                )),
            SizedBox(
              height: 20,
            ),
            _buildListTile(Icons.restaurant, 'Meal', () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabScreen(
                            favorites: favorites,
                            addFav: addFav,
                          )));
            }),
            _buildListTile(Icons.filter, 'Filter', () {
              Navigator.pushReplacementNamed(context, '/Filter_screen');
            }),
          ],
        ),
      ),
    );
  }
}
