// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/todo_list/todo_list_collection.dart';
import 'package:reminder/screens/add_list/add_list_screen.dart';
import 'package:reminder/screens/add_reminder/add_reminder_screen.dart';
import 'package:reminder/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.bottom,
      ],
    );
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ChangeNotifierProvider<TodoListCollection>(
        create: (BuildContext context) {
          return TodoListCollection();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            "/": (context) => HomeScreen(),
            "/addList": (context) => AddListScreen(),
            "/addReminder": (context) => AddReminderScreen(),
          },
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
            dividerColor: Colors.grey.shade900,
          ),
        ),
      ),
    );
  }
}
