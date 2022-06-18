import 'package:flutter/material.dart';
import 'package:reminder/models/category/category.dart';
import 'package:reminder/models/category/category_collection.dart';

class SelectReminderCategoryScreen extends StatelessWidget {
  final Category selectedCategory;
  final Function(Category) onSelectCategory;

  const SelectReminderCategoryScreen(
      {required this.selectedCategory, required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Reminder Category'),
      ),
      body: ListView.builder(
        itemCount: CategoryCollection().categories.length,
        itemBuilder: (context, index) {
          final item = CategoryCollection().categories[index];
          if (item.id == 'all') {
            return Container();
          }
          return ListTile(
            onTap: () {
              onSelectCategory(item);
              Navigator.pop(context);
            },
            title: Text(
              item.name,
            ),
            trailing:
                item.name == selectedCategory.name ? Icon(Icons.check) : null,
          );
        },
      ),
    );
  }
}
