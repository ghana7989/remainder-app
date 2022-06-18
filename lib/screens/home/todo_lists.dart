import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/common/widgets/category_icon.dart';
import 'package:reminder/models/common/custom_color_collection.dart';
import 'package:reminder/models/common/custom_icon_collection.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/screens/view_list/view_list_screen.dart';
import 'package:reminder/services/db_service.dart';

class TodoLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    final todoLists = Provider.of<List<TodoList>>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Lists',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: todoLists.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) {
                    try {
                      DbService(uid: user.uid).deleteTodoList(todoLists[index]);
                    } catch (e) {
                      print(e);
                    }
                  },
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
                  key: UniqueKey(),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ListTile(
                          onTap: todoLists[index].reminderCount > 0
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewListScreen(
                                            todoList: todoLists[index])),
                                  );
                                }
                              : null,
                          leading: CategoryIcon(
                            bgColor: (CustomColorCollection().findColorById(
                              todoLists[index].icon["color"],
                            )).color,
                            iconData: (CustomIconCollection().findIconById(
                              todoLists[index].icon["id"],
                            )).icon,
                          ),
                          title: Text(
                            todoLists[index].title,
                          ),
                          trailing: Text(
                            todoLists[index].reminderCount.toString(),
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
