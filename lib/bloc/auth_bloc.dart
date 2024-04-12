import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fourth_step/ui/home.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        switch (event) {
          case SignInAuth():
            await _signIn(event, emit);
          case LogInAuth():
            await _logIn(event, emit);
          case SignOutAuth():
            await _signOut(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _signIn(
    SignInAuth event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthInProgress(progress: AuthVarProgrss.signInProgress));
      if (event.email.length < 4 ||
          !event.email.contains('@') ||
          !event.email.contains('.')) {
        emit(AuthException(emailError: 'Invalid email', passwordError: null));
        return;
      } else if (event.password.length < 5) {
        emit(AuthException(
            emailError: null, passwordError: 'Password too short'));
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(
        email: event.email,
        password: event.password,
      ));

      final context = event.context;
      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePageWidget(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthException(
            emailError: null,
            passwordError: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthException(
          emailError: 'The account already exists for that email.',
          passwordError: null,
        ));
      } else if (e.code == 'invalid-email') {
        emit(AuthException(emailError: 'Invalid email', passwordError: null));
      } else {
        emit(AuthException(
          emailError: e.message.toString(),
          passwordError: e.message.toString(),
        ));
      }
    }
  }

  Future<void> _logIn(
    LogInAuth event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthInProgress(progress: AuthVarProgrss.logInProgress));
      if (event.email.length < 4 ||
          !event.email.contains('@') ||
          !event.email.contains('.')) {
        emit(AuthException(emailError: 'Invalid email', passwordError: null));
        return;
      } else if (event.password.length < 5) {
        emit(AuthException(
            emailError: null, passwordError: 'Password too short'));
        return;
      }
      final context = event.context;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(
        email: event.email,
        password: event.password,
      ));

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePageWidget(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthException(
          emailError: 'No user found for that email.',
          passwordError: null,
        ));
      } else if (e.code == 'wrong-password') {
        emit(AuthException(
          emailError: null,
          passwordError: 'Wrong password provided for that user.',
        ));
      } else {
        emit(AuthException(
          emailError: e.message.toString(),
          passwordError: e.message.toString(),
        ));
      }
    }
  }

  Future<void> _signOut(
    SignOutAuth event,
    Emitter<AuthState> emit,
  ) async {
    final context = event.context;
    emit(AuthInitial());
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
