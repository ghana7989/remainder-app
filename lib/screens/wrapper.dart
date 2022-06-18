// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/config/custom_theme.dart';
import 'package:reminder/models/reminder/reminder.dart';
import 'package:reminder/models/todo_list/todo_list.dart';
import 'package:reminder/screens/add_list/add_list_screen.dart';
import 'package:reminder/screens/add_reminder/add_reminder_screen.dart';
import 'package:reminder/screens/auth/authenticate_screen.dart';
import 'package:reminder/screens/home/home_screen.dart';
import 'package:reminder/services/db_service.dart';

class Wrapper extends StatelessWidget {
  Wrapper({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final customTheme = Provider.of<CustomTheme>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<TodoList>>.value(
          initialData: [],
          value:
              user != null ? DbService(uid: user.uid).todoListStream() : null,
        ),
        StreamProvider<List<Reminder>>.value(
          initialData: [],
          value:
              user != null ? DbService(uid: user.uid).reminderStream() : null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/home": (context) => HomeScreen(),
          "/addList": (context) => AddListScreen(),
          "/addReminder": (context) => AddReminderScreen(),
        },
        home: user != null ? HomeScreen() : AuthenticateScreen(),
        theme: customTheme.lightTheme,
        darkTheme: customTheme.darkTheme,
        themeMode: customTheme.currentTheme(),
      ),
    );
  }
}
