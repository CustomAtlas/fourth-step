import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourth_step/bloc/auth_bloc.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final controllerE = TextEditingController();
  final controllerP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const buttonStyle = ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(Colors.blue),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Align(
          alignment: const Alignment(0, -0.3),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<AuthBloc>(context);
              final emailError =
                  state is AuthException ? state.emailError?.toString() : null;
              final passwordError = state is AuthException
                  ? state.passwordError?.toString()
                  : null;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: controllerE,
                    cursorHeight: 20,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: emailError,
                    ),
                  ),
                  TextFormField(
                    controller: controllerP,
                    cursorHeight: 20,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: passwordError,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          state is AuthInProgress
                              ? null
                              : bloc.add(
                                  LogInAuth(
                                      email: controllerE.text,
                                      password: controllerP.text,
                                      context: context),
                                );
                        },
                        style: buttonStyle,
                        child: state is AuthInProgress &&
                                state.progress == AuthVarProgrss.logInProgress
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator())
                            : const Text('LOGIN'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          state is AuthInProgress
                              ? null
                              : bloc.add(
                                  SignInAuth(
                                      email: controllerE.text,
                                      password: controllerP.text,
                                      context: context),
                                );
                        },
                        style: buttonStyle,
                        child: state is AuthInProgress &&
                                state.progress == AuthVarProgrss.signInProgress
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator())
                            : const Text('SIGN IN'),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllerE.dispose();
    controllerE.dispose();
    super.dispose();
  }
}
