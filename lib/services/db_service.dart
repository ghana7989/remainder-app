import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminder/models/reminder/reminder.dart';
import 'package:reminder/models/todo_list/todo_list.dart';

class DbService {
  final String uid;
  final FirebaseFirestore _database;
  final DocumentReference _userRef;

  DbService({required this.uid})
      : _userRef = FirebaseFirestore.instance.collection('users').doc(uid),
        _database = FirebaseFirestore.instance;

  Stream<List<TodoList>> todoListStream() {
    return _userRef.collection('todo_lists').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (todoListSnapshot) => TodoList.fromJson(
                  todoListSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Reminder>> reminderStream() {
    return _userRef.collection('reminders').snapshots().map(
          (snapshot) => snapshot.docs
              .map((reminderSnapshot) =>
                  Reminder.fromJson(reminderSnapshot.data()))
              .toList(),
        );
  }

  void addTodoList(TodoList todoList) async {
    final todoListRef = _userRef.collection("todo_lists").doc();

    todoList.id = todoListRef.id;
    try {
      await todoListRef.set(
        todoList.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  void deleteTodoList(TodoList list) async {
    try {
      var batch = FirebaseFirestore.instance.batch();
      final todoListRef = _userRef.collection('todo_lists').doc(list.id);
      final reminderSnapshot = await _userRef
          .collection('reminders')
          .where('list.id', isEqualTo: list.id)
          .get();
      reminderSnapshot.docs.forEach((reminderDoc) {
        print(reminderDoc.id);
        batch.delete(reminderDoc.reference);
      });
      batch.delete(todoListRef);
      try {
        await batch.commit();
      } catch (e) {
        print(e);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addReminder({required Reminder reminder}) async {
    var reminderRef = _userRef.collection('reminders').doc();
    reminder.id = reminderRef.id;
    final listRef = _userRef.collection('todo_lists').doc(reminder.list['id']);
    var batch = FirebaseFirestore.instance.batch();
    batch.set(reminderRef, reminder.toJson());
    batch.update(listRef, {
      'reminder_count': reminder.list['reminder_count'] + 1,
    });
    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
