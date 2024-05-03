import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/components/homeMenu.dart';
import 'package:note_taking/pages/account.dart';
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
  late Login loginPage = const Login();
  late Register registerPage = const Register();
  late Account accountPage = const Account();

  // FirebaseDatabase database = FirebaseDatabase.instance;
  // database.ref("users").set(FirebaseAuth.instance.currentUser?.uid) {

  late final nav = HomeMenu(menuFunctions: {
    gotoNotes: Icons.edit_note_rounded,
    gotoCalendar: Icons.calendar_month_rounded,
    gotoAccount: Icons.account_box_rounded,
  });

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
      showNav = true;
    });
  }

  void gotoAccount() {
    setState(() {
      currentPage = accountPage;
      showNav = true;
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
