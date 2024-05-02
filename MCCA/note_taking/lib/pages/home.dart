import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/homeMenu.dart';
import 'package:note_taking/pages/calendar.dart';
import 'package:note_taking/pages/login.dart';
import 'package:note_taking/pages/notes.dart';
import 'package:note_taking/pages/register.dart';
import 'package:note_taking/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static _HomePageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomePageState>();
}

class _HomePageState extends State<HomePage> {
  late Widget currentPage;
  late bool showNav;

  late Notes notesPage = const Notes();
  late Calendar calendarPage = const Calendar();
  late Login loginPage = Login();
  late Register registerPage = Register();

  late final nav = HomeMenu(menuFunctions: [
    gotoNotes,
    gotoCalendar,
  ]);

  void gotoLogin() {
    setState(() {
      currentPage = loginPage;
      showNav = false;
    });
  }

  void gotoRegister() {
    setState(() {
      currentPage = registerPage;
      showNav = false;
    });
  }

  void gotoNotes() {
    setState(() {
      currentPage = notesPage;
      showNav = true;
    });
  }

  void gotoCalendar() {
    setState(() {
      currentPage = calendarPage;
      showNav = false;
    });
  }

  @override
  void initState() {
    super.initState();
    showNav = false;
    currentPage = loginPage;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        gotoLogin();
      } else {
        gotoNotes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: ThemeColors.gruvLight,
        ),
        currentPage,
        if (showNav) nav,
      ],
    );
  }
}
