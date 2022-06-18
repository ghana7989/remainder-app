import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/common/custom_color.dart';
import 'package:reminder/models/common/custom_color_collection.dart';
import 'package:reminder/models/common/custom_icon.dart';
import 'package:reminder/models/common/custom_icon_collection.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/models/todo_list/todo_list_collection.dart';
import 'package:reminder/services/db_service.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({Key? key}) : super(key: key);

  @override
  State<AddListScreen> createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  CustomColor _selectedColor = CustomColorCollection().colors.first;
  CustomIcon _selectedIcon = CustomIconCollection().icons.first;
  final TextEditingController _textController = TextEditingController();

  String _listName = "";

  void addNewList(TodoList list) {
    Provider.of<TodoListCollection>(context, listen: false).addTodoList(list);
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _listName = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New List'),
        actions: [
          TextButton(
            onPressed: _listName.isEmpty
                ? null
                : () async {
                    if (_textController.text.isNotEmpty) {
                      final user = Provider.of<User>(context, listen: false);

                      final newTodoList = TodoList(
                        id: null,
                        title: _textController.text,
                        icon: {
                          "id": _selectedIcon.id,
                          "color": _selectedColor.id,
                        },
                        reminderCount: 0,
                      );
                      try {
                        DbService(uid: user.uid).addTodoList(newTodoList);
                      } catch (e) {
                        print(e);
                      }
                    }
                    Navigator.pop(context);
                  },
            child: Text(
              'Add',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedColor.color,
              ),
              child: Icon(
                _selectedIcon.icon,
                size: 75,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _textController,
                autofocus: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'List name',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final customColor in CustomColorCollection().colors)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = customColor;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: _selectedColor.id == customColor.id
                            ? Border.all(
                                color: Colors.white60,
                                width: 5,
                              )
                            : null,
                        shape: BoxShape.circle,
                        color: customColor.color,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final customIcon in CustomIconCollection().icons)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon = customIcon;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: _selectedIcon.id == customIcon.id
                            ? Border.all(
                                color: Colors.white60,
                                width: 5,
                              )
                            : null,
                      ),
                      child: Icon(
                        customIcon.icon,
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
