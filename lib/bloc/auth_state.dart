part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

enum AuthVarProgrss { logInProgress, signInProgress }

class AuthInProgress extends AuthState {
  final AuthVarProgrss progress;

  AuthInProgress({required this.progress});
  @override
  List<Object?> get props => [progress];
}

class AuthSuccess extends AuthState {
  final String email;
  final String password;

  AuthSuccess({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthException extends AuthState {
  final Object? emailError;
  final Object? passwordError;

  AuthException({
    required this.emailError,
    required this.passwordError,
  });

  @override
  List<Object?> get props => [emailError, passwordError];
}
