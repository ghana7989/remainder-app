import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }
}
