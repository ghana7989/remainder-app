import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/common/widgets/category_icon.dart';
import 'package:reminder/models/common/custom_color_collection.dart';
import 'package:reminder/models/common/custom_icon_collection.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/models/todo_list/todo_list_collection.dart';

class TodoLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void deleteTodoList(TodoList list) {
      Provider.of<TodoListCollection>(context, listen: false)
          .removeTodoList(list);
    }

    final todoLists = Provider.of<TodoListCollection>(context).todoLists;
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
                    deleteTodoList(todoLists[index]);
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
                            "0",
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