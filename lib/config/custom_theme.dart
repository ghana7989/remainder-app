import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme extends ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeMode currentTheme() {
    return _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      elevation: 0,
    ),
    brightness: Brightness.dark,
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
  );
  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffeeeeee),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black38,
      elevation: 0,
    ),
    brightness: Brightness.light,
    accentColor: Colors.black,
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
  );
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
