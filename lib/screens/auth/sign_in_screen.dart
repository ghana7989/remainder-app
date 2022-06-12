import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reminder/screens/home/home_screen.dart';
import 'package:reminder/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback toggleView;
  SignInScreen({
    required this.toggleView,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset(
              'assets/images/todo-lottie.json',
              width: 175,
              frameRate: FrameRate.max,
            ),
            Text(
              'Yet another Todo list',
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => v == null || !v.contains('@')
                          ? 'Invalid Email'
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        isDense: true,
                      ),
                      obscureText: true,
                      validator: (v) => v == null || v.length < 6
                          ? 'Enter a password of minimum 6 characters'
                          : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final user =
                              await AuthService().signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        } else {
                          print('Form is invalid');
                        }
                      },
                      child: Text('Sign In'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
