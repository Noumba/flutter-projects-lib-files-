import 'package:flutter/material.dart';
import 'package:mealapp/widgets/category_item.dart';
import 'package:mealapp/dummy_data.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          mainAxisSpacing: 7.0,
          crossAxisSpacing: 5.0),
      children: dummy_categories
          .map((catItem) => CategoryItem(
                title: catItem.title,
                color: catItem.color,
                id: catItem.id,
              ))
          .toList(),
    );
  }
}
