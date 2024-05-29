import 'dart:convert';

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

  late Notes notesPage = Notes();
  late Calendar calendarPage = const Calendar();
  late Login loginPage = const Login();
  late Register registerPage = const Register();
  late Account accountPage = const Account();
  late String imageString = "";
  late String textString = "";
  late bool requireLatest = true;

  // FirebaseDatabase database = FirebaseDatabase.instance;
  // database.ref("users").set(FirebaseAuth.instance.currentUser?.uid) {

  late final nav = HomeMenu(menuFunctions: {
    gotoNotes: Icons.edit_note_rounded,
    gotoCalendar: Icons.calendar_month_rounded,
    gotoFiles: Icons.folder_copy,
    gotoAccount: Icons.account_box_rounded,
  });

  void gotoNotes() async {
    setNotesValues();
    setState(() {
      currentPage = notesPage;
      showNav = true;
    });
  }

  void gotoLogin() {
    saveNoteValues();
    setState(() {
      currentPage = loginPage;
      showNav = false;
    });
  }

  void gotoRegister() {
    saveNoteValues();
    setState(() {
      currentPage = registerPage;
      showNav = false;
    });
  }

  void gotoCalendar() {
    saveNoteValues();
    setState(() {
      currentPage = calendarPage;
      showNav = true;
    });
  }

  void gotoFiles() {
    saveNoteValues();
    debugPrint("WIP");
  }

  void gotoAccount() {
    saveNoteValues();
    setState(() {
      currentPage = accountPage;
      showNav = true;
    });
  }

  void setNotesValues() async {
    await Future.delayed(const Duration(seconds: 1));
    if (requireLatest) {
      var json = await getLatestValues();
      imageString = json['image'] as String;
      textString = json['text'] as String;
      notesPage.clearValues();
      requireLatest = false;
    }

    notesPage.setValues(imageString, textString);
  }

  saveNoteValues() async {
    await Future.delayed(const Duration(seconds: 1));
    imageString = notesPage.getImage();
    textString = notesPage.getText();
  }

  Future<Map> getLatestValues() async {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref('users/$userID');
    DataSnapshot data = await ref.child('latest').get();
    return data.value as Map;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    showNav = false;
    currentPage = loginPage;

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        debugPrint("not logged");
        gotoLogin();
      } else {
        debugPrint("logged");

        DatabaseReference ref = FirebaseDatabase.instance.ref('users');
        final userSpace = await ref.child(user.uid).get();
        if (!userSpace.exists) {
          ref.child(user.uid).set({
            "latest": {
              "image": "",
              "text": "",
            },
            "calendar": "",
          });
        }

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
