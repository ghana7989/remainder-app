import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/screens/add_list/add_list_screen.dart';
import 'package:reminder/screens/add_reminder/add_reminder_screen.dart';

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            icon: Icon(Icons.add_circle),
            label: Text("New Reminder"),
            onPressed: todoLists.length > 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddReminderScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  }
                : null,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddListScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Text("Add List"),
          ),
        ],
      ),
    );
  }
}
