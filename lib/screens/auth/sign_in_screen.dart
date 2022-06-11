import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback toggleView;
  SignInScreen({
    required this.toggleView,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person_outline),
            label: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
