import 'package:flutter/material.dart';
import 'package:fourth_step/ui/home.dart';

abstract class CoreAuthModel {
  Future<void> signIn({
    required String email,
    required String password,
    required String? error,
  });

  Future<void> logIn({
    required String email,
    required String password,
    required String? error,
  });

  void signOut();
}

class CoreAuth {
  final CoreAuthModel? model;
  final String email;
  final String password;
  String? error;
  CoreAuth({
    required this.model,
    required this.email,
    required this.password,
    required this.error,
  });

  Future<void> signIn(BuildContext context) async {
    model?.signIn(
      email: email,
      password: password,
      error: error,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const HomePageWidget()),
      ),
    );
  }

  Future<void> logIn(BuildContext context) async {
    model?.logIn(
      email: email,
      password: password,
      error: error,
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const HomePageWidget()),
      ),
    );
  }

  void signOut(BuildContext context) {
    model?.signOut();
    Navigator.of(context).pop();
  }

  void clone() {
    debugPrint('fsdfd');
  }

  void secondClone() {}
}
