import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  const CategoryItem(
      {Key? key, required this.id, required this.title, required this.color})
      : super(key: key);

  void _selectedCategory(BuildContext context) {
    Navigator.pushNamed(context, '/Category_meals',
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _selectedCategory(context);
        },
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Text(title),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [color.withOpacity(0.7), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(15.0)),
        ),
      ),
    );
  }
}
