import 'package:flutter/material.dart';
import 'package:reminder/common/widgets/category_icon.dart';
import 'package:reminder/models/todo_list/todo_list.dart';

class SelectReminderListScreen extends StatelessWidget {
  final List<TodoList> todoLists;
  final TodoList selectedList;
  final Function(TodoList) onSelectList;

  const SelectReminderListScreen({
    required this.todoLists,
    required this.selectedList,
    required this.onSelectList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Reminder List'),
      ),
      body: ListView.builder(
        itemCount: todoLists.length,
        itemBuilder: (context, index) {
          final item = todoLists[index];
          return ListTile(
            onTap: () {
              onSelectList(item);
              Navigator.pop(context);
            },
            title: Text(item.title),
            trailing:
                item.title == selectedList.title ? Icon(Icons.check) : null,
          );
        },
      ),
    );
  }
}
