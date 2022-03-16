import 'package:flutter/material.dart';
import 'package:mealapp/models/meals.dart';
import 'package:mealapp/screens/drawer_screen.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilter;
  final Map<String, bool> currentFilters;
  final List<Meal> favorites;
  final Function addFav;
  FilterScreen(
      {required this.saveFilter,
      required this.currentFilters,
      required this.favorites,
      required this.addFav});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _lactoseFree = false;
  var _gluttenFree = false;
  var _isVegeterian = false;
  var _vegan = false;

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: (newValue) => updateValue(newValue),
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  void initState() {
    _gluttenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _isVegeterian = widget.currentFilters['vegeterian'] as bool;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters'), actions: <Widget>[
        IconButton(
            onPressed: () {
              final _selectedFilters = {
                'lactose': _lactoseFree,
                'gluten': _gluttenFree,
                'vegan': _vegan,
                'vegeterian': _isVegeterian
              };
              widget.saveFilter(_selectedFilters);
            },
            icon: Icon(Icons.save))
      ]),
      drawer: DrawerScreen(
        favorites: widget.favorites,
        addFav: widget.addFav,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile("Gluten-Free",
                  "Only include glutten-free meals", _gluttenFree, (newValue) {
                setState(() {
                  _gluttenFree = newValue;
                });
              }),
              _buildSwitchListTile("Lactose-free",
                  "Only include lactose-free meals", _lactoseFree, (newValue) {
                setState(() {
                  _lactoseFree = newValue;
                });
              }),
              _buildSwitchListTile(
                  "Vegeterian", "Only include vegeterian meals", _isVegeterian,
                  (newValue) {
                setState(() {
                  _isVegeterian = newValue;
                });
              }),
              _buildSwitchListTile("Vegan", "Only include vegan meals", _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                  print(newValue);
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
