import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:reminder/models/todo_list/todo_list.dart';

class TodoListCollection with ChangeNotifier {
  final List<TodoList> _todoLists = [];

  UnmodifiableListView<TodoList> get todoLists =>
      UnmodifiableListView(_todoLists);

  void addTodoList(TodoList todoList) {
    _todoLists.add(todoList);
    notifyListeners();
  }

  void removeTodoList(TodoList todoList) {
    _todoLists.removeWhere((element) => element.id == todoList.id);
    notifyListeners();
  }
}
