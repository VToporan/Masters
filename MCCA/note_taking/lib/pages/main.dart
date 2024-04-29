import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/mainMenu.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/textbox.dart';
import 'package:note_taking/pages/calendar.dart';
import 'package:note_taking/pages/notes.dart';
import 'package:note_taking/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  final Notes notesPage = const Notes();
  final Calendar calendarPage = const Calendar();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Widget currentPage;

  late final pageMenu = MainMenu(menuFunctions: [
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
  ]);

  @override
  void initState() {
    super.initState();
    currentPage = widget.calendarPage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        currentPage,
        pageMenu,
      ],
    );
  }
}
