// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/models/todo_list/todo_list_collection.dart';
import 'package:reminder/screens/add_list/add_list_screen.dart';
import 'package:reminder/screens/add_reminder/add_reminder_screen.dart';
import 'package:reminder/screens/auth/authenticate_screen.dart';
import 'package:reminder/screens/home/home_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final todoListStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('todo_lists')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (todoListSnapshot) => TodoList.fromJson(
                  todoListSnapshot.data(),
                ),
              )
              .toList(),
        );
    return StreamProvider<List<TodoList>>.value(
      initialData: [],
      value: todoListStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/home": (context) => HomeScreen(),
          "/addList": (context) => AddListScreen(),
          "/addReminder": (context) => AddReminderScreen(),
        },
        home: user != null ? HomeScreen() : AuthenticateScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            elevation: 0,
          ),
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          accentColor: Colors.white,
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
          ),
          dividerColor: Colors.grey.shade900,
        ),
      ),
    );
  }
}
