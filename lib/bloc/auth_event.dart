part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {}

class SignInAuth extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignInAuth({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [email, password, context];
}

class LogInAuth extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  LogInAuth({
    required this.email,
    required this.password,
    required this.context,
  });
  @override
  List<Object?> get props => [email, password, context];
}

class SignOutAuth extends AuthEvent {
  final BuildContext context;

  SignOutAuth({required this.context});
  @override
  List<Object?> get props => [context];
}
