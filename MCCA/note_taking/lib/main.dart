import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:circular_menu/circular_menu.dart';
import 'package:note_taking/pages/calendar.dart';
import 'package:note_taking/pages/main.dart';
import 'package:note_taking/pages/notes.dart';

import 'package:note_taking/theme.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/textbox.dart';

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
            const MainPage(),
          ],
        ),
      ),
    ),
  );
}
