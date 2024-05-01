import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/homeMenu.dart';
import 'package:note_taking/pages/calendar.dart';
import 'package:note_taking/pages/login.dart';
import 'package:note_taking/pages/notes.dart';
import 'package:note_taking/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final Notes notesPage = const Notes();
  final Calendar calendarPage = const Calendar();
  final Login loginPage = const Login();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget currentPage;

  late final pageMenu = HomeMenu(menuFunctions: [
    () {
      setState(() {
        currentPage = widget.calendarPage;
      });
    },
    () {
      setState(() {
        currentPage = widget.notesPage;
      });
    },
    () {
      setState(() {
        currentPage = widget.loginPage;
      });
    },
  ]);

  @override
  void initState() {
    super.initState();
    currentPage = widget.loginPage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: ThemeColors.gruvLight,
        ),
        currentPage,
        pageMenu,
      ],
    );
  }
}
