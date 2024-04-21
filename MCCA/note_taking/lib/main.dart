import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/textbox.dart';
import 'package:note_taking/theme.dart';
import 'package:note_taking/handwriting.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: ThemeColors.gruvLight,
            ),
          ],
        ),
      ),
    ),
  );
}
