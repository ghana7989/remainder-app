import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminder/screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        // SystemUiOverlay.bottom,
      ],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0,
        ),
        brightness: Brightness.dark,
      ),
    );
  }
}
