import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fourth_step/bloc/auth_bloc.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthBloc>(context);
        final email = state is AuthSuccess ? state.email : 'email';
        final password = state is AuthSuccess ? state.password : 'password';
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: const Text('Flutter login demo'),
            actions: [
              TextButton(
                onPressed: () => bloc.add(SignOutAuth(context: context)),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 140),
                _EmailOrPasswordTextWidget('email', email),
                _EmailOrPasswordTextWidget('password', password),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmailOrPasswordTextWidget extends StatelessWidget {
  const _EmailOrPasswordTextWidget(this.label, this.text);

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$label: $text',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }
}
