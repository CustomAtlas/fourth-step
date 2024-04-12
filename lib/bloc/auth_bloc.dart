import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fourth_step/domain/core.dart';

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
    emit(AuthInProgress(progress: AuthVarProgrss.signInProgress));
    final core = CoreAuth(
      email: event.email,
      password: event.password,
    );
    await core.signIn(event.context);
    if (core.hasException) {
      emit(AuthException(
        emailError: core.emailError,
        passwordError: core.passwordError,
      ));
      return;
    }
    emit(AuthSuccess(email: event.email, password: event.password));
  }

  Future<void> _logIn(
    LogInAuth event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgress(progress: AuthVarProgrss.logInProgress));
    final core = CoreAuth(email: event.email, password: event.password);
    await core.logIn(event.context);
    if (core.hasException) {
      emit(AuthException(
        emailError: core.emailError,
        passwordError: core.passwordError,
      ));
      return;
    }
    emit(AuthSuccess(email: event.email, password: event.password));
  }

  Future<void> _signOut(
    SignOutAuth event,
    Emitter<AuthState> emit,
  ) async {
    final core = CoreAuth(email: '', password: '');
    emit(AuthInitial());
    await core.signOut(event.context);
  }
}
