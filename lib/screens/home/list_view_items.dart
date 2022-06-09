import 'package:flutter/material.dart';
import 'package:reminder/models/category/category_collection.dart';

const LIST_VIEW_HEIGHT = 70.0;

class ListViewItems extends StatefulWidget {
  final CategoryCollection categoryCollection;

  const ListViewItems({required this.categoryCollection});

  @override
  State<ListViewItems> createState() => _ListViewItemsState();
}

class _ListViewItemsState extends State<ListViewItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: LIST_VIEW_HEIGHT * widget.categoryCollection.categories.length,
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex--;
          }
          final item = widget.categoryCollection.removeItem(oldIndex);
          setState(() {
            widget.categoryCollection.insert(newIndex, item);
          });
        },
        children: widget.categoryCollection.categories.map(
          (category) {
            return SizedBox(
              key: UniqueKey(),
              // height: LIST_VIEW_HEIGHT,
              child: ListTile(
                onTap: () {
                  // toggle checkbox
                  setState(() {
                    category.toggleCheckbox();
                  });
                },
                key: UniqueKey(),
                contentPadding: EdgeInsets.all(10),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: category.isChecked
                        ? Colors.blueAccent
                        : Colors.transparent,
                    border: Border.all(
                      color:
                          category.isChecked ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                  child: Icon(
                    Icons.check,
                    color:
                        category.isChecked ? Colors.white : Colors.transparent,
                  ),
                ),
                title: Row(
                  children: [
                    category.icon,
                    SizedBox(width: 10),
                    Text(category.name),
                  ],
                ),
                trailing: Icon(Icons.reorder),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
