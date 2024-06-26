import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fourth_step/infrastructure/firebase_options.dart';
import 'package:fourth_step/ui/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
