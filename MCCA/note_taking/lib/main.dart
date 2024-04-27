import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:circular_menu/circular_menu.dart';

import 'package:note_taking/theme.dart';
import 'package:note_taking/handwriting.dart';
import 'package:note_taking/textbox.dart';

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
            const TextBox(),
            Transform.scale(
              scaleX: -1,
              child: CircularMenu(
                  alignment: const Alignment(1.0, 0.7),
                  radius: 80,
                  curve: Curves.easeInOutSine,
                  reverseCurve: Curves.easeInOutSine,
                  // first item angle
                  startingAngleInRadian: (1 / 2) * pi,
                  // toggle button callback
                  endingAngleInRadian: (3 / 2) * pi,
                  toggleButtonOnPressed: () {
                    //callback
                  },
                  // toggle button appearance properties
                  toggleButtonColor: ThemeColors.gruvPink,
                  toggleButtonIconColor: ThemeColors.gruvLight,
                  toggleButtonMargin: 10.0,
                  toggleButtonPadding: 10.0,
                  toggleButtonSize: 30.0,
                  items: [
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.person,
                        onTap: () {
                          //callback
                        }),
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.library_books,
                        onTap: () {
                          //callback
                        }),
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.calendar_month,
                        onTap: () {
                          //callback
                        }),
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.today,
                        onTap: () {
                          //callback
                        }),
                  ]),
            ),
            Transform.scale(
              scaleX: 1,
              child: CircularMenu(
                  alignment: const Alignment(1.0, 0.3),
                  radius: 80,
                  curve: Curves.easeInOutSine,
                  reverseCurve: Curves.easeInOutSine,
                  // first item angle
                  startingAngleInRadian: (1 / 2) * pi,
                  // toggle button callback
                  endingAngleInRadian: (3 / 2) * pi,
                  toggleButtonOnPressed: () {
                    //callback
                  },
                  // toggle button appearance properties
                  toggleButtonColor: ThemeColors.gruvPink,
                  toggleButtonIconColor: ThemeColors.gruvLight,
                  toggleButtonMargin: 10.0,
                  toggleButtonPadding: 10.0,
                  toggleButtonSize: 30.0,
                  items: [
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.person,
                        onTap: () {
                          //callback
                        }),
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.library_books,
                        onTap: () {
                          //callback
                        }),
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.calendar_month,
                        onTap: () {
                          //callback
                        }),
                    CircularMenuItem(
                        color: ThemeColors.gruvLight,
                        iconColor: ThemeColors.gruvDark,
                        icon: Icons.today,
                        onTap: () {
                          //callback
                        }),
                  ]),
            ),
          ],
        ),
      ),
    ),
  );
}
