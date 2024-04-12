import 'package:firebase_auth/firebase_auth.dart';

class MyAuth {
  String? emailError;
  String? passwordError;
  bool hasException = false;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      hasException = true;
      if (e.code == 'email-already-in-use') {
        emailError = 'The account already exists for that email.';
        passwordError = null;
      } else {
        emailError = e.message.toString();
        passwordError = e.message.toString();
      }
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      hasException = true;
      if (e.code == 'user-not-found') {
        emailError = 'No user found for that email.';
        passwordError = null;
      } else if (e.code == 'wrong-password') {
        emailError = null;
        passwordError = 'Wrong password provided for that user.';
      } else {
        emailError = e.message.toString();
        passwordError = e.message.toString();
      }
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
