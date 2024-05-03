import 'package:flutter/material.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final pageMenu = PageMenu(menuFunctions: {
    () {}: Icons.abc,
    () {}: Icons.abc,
    () {}: Icons.abc,
    () {}: Icons.abc,
    () {}: Icons.abc,
  });
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  List<int> _getEventsForDay(DateTime day) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2045),
            focusedDay: _focusedDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            weekNumbersVisible: true,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: ThemeColors.gruvDark),
              weekendStyle: TextStyle(color: ThemeColors.gruvRed),
            ),
            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                color: ThemeColors.gruvDark,
                fontSize: 20,
              ),
              formatButtonVisible: false,
            ),
            calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(color: ThemeColors.gruvLight),
              weekendTextStyle: TextStyle(color: ThemeColors.gruvRed),
              outsideTextStyle: TextStyle(color: ThemeColors.gruvGray),
              weekNumberTextStyle: TextStyle(
                color: ThemeColors.gruvPink,
                fontSize: 12,
              ),
              defaultTextStyle: TextStyle(
                color: ThemeColors.gruvDark,
                fontSize: 16,
              ),
              todayDecoration: BoxDecoration(
                color: ThemeColors.gruvYellow,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: ThemeColors.gruvPink,
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                print(focusedDay.hashCode);
                print(focusedDay);
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
          ),
        ),
        pageMenu,
      ],
    );
  }
}
