import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/common/helpers/helpers.dart' as helpers;
import 'package:reminder/models/category/category.dart';
import 'package:reminder/models/reminder/reminder.dart';
import 'package:reminder/models/todo_list/todo_list.dart';

class ViewListByCategoryScreen extends StatelessWidget {
  final Category category;
  const ViewListByCategoryScreen({Key? key, required this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final reminderForCategory = allReminders
        .where((reminder) =>
            reminder.categoryId == category.id || category.id == "all")
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemCount: reminderForCategory.length,
        itemBuilder: (context, index) {
          final item = reminderForCategory[index];
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Icon(
                  Icons.delete_forever,
                ),
              ),
            ),
            onDismissed: (direction) async {
              final user = Provider.of<User?>(context);
              final todoLists =
                  Provider.of<List<TodoList>>(context, listen: false);
              final todoList = todoLists
                  .firstWhere((todoList) => todoList.id == item.list['id']);
              var batch = FirebaseFirestore.instance.batch();
              final reminderRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('reminders')
                  .doc(item.id);
              final listRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(user?.uid)
                  .collection('todo_lists')
                  .doc(item.list['id']);
              batch.delete(reminderRef);
              batch.update(
                  listRef, {"reminder_count": todoList.reminderCount - 1});
              await batch.commit();
            },
            child: Card(
              child: ListTile(
                title: Text(item.title),
                subtitle: Text(item.notes ?? ''),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      helpers.formatDate(item.dueDate),
                    ),
                    Text(
                      helpers.formatTime(
                        context,
                        item.dueTime['hour'],
                        item.dueTime['minute'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
