import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/firebase_options.dart';

import 'package:note_taking/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseDatabase database = FirebaseDatabase.instance;

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Note taker"),
        ),
        body: const HomePage(),
      ),
    ),
  );
}
