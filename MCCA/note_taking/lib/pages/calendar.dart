import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/textbox.dart';
import 'package:note_taking/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final pageMenu = PageMenu(menuFunctions: [() {}, () {}, () {}]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            weekNumbersVisible: true,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: ThemeColors.gruvDark),
              weekendStyle: TextStyle(color: ThemeColors.gruvRed),
            ),
            calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(color: ThemeColors.gruvLight),
              weekendTextStyle: TextStyle(color: ThemeColors.gruvRed),
              weekNumberTextStyle: TextStyle(
                color: ThemeColors.gruvPink,
                fontSize: 12,
              ),
              defaultTextStyle: TextStyle(
                color: ThemeColors.gruvDark,
                fontSize: 16,
              ),
              todayDecoration: BoxDecoration(
                color: ThemeColors.gruvPink,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: ThemeColors.gruvAqua,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        pageMenu,
      ],
    );
  }
}
