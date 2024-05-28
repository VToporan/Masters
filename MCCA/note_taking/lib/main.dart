import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/firebase_options.dart';

import 'package:note_taking/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    ),
  );
}
