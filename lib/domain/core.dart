import 'package:flutter/material.dart';
import 'package:fourth_step/infrastructure/firebase.dart';
import 'package:fourth_step/ui/home.dart';

class CoreAuth {
  final String email;
  final String password;
  CoreAuth({
    required this.email,
    required this.password,
  });

  final myAuth = MyAuth();
  bool hasException = false;
  String? emailError;
  String? passwordError;

  Future<void> signIn(BuildContext context) async {
    if (email.length < 4 || !email.contains('@') || !email.contains('.')) {
      emailError = 'Invalid email';
      passwordError = null;
      hasException = true;
      return;
    } else if (password.length < 6) {
      emailError = null;
      passwordError = 'Password too short';
      hasException = true;
      return;
    }

    await myAuth.signIn(email: email, password: password);
    emailError = myAuth.emailError;
    passwordError = myAuth.passwordError;
    hasException = myAuth.hasException;

    if (context.mounted && !hasException) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => const HomePageWidget()),
        ),
      );
    }
  }

  Future<void> logIn(BuildContext context) async {
    if (email.length < 4 || !email.contains('@') || !email.contains('.')) {
      emailError = 'Invalid email';
      passwordError = null;
      hasException = true;
      return;
    } else if (password.length < 6) {
      emailError = null;
      passwordError = 'Password too short';
      hasException = true;
      return;
    }

    await myAuth.logIn(email: email, password: password);
    emailError = myAuth.emailError;
    passwordError = myAuth.passwordError;
    hasException = myAuth.hasException;

    if (context.mounted && !hasException) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => const HomePageWidget()),
        ),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    await myAuth.signOut();
    if (context.mounted) Navigator.of(context).pop();
  }
}
