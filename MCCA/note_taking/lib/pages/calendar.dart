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
  late final pageMenu = PageMenu(menuFunctions: [
    () async {
      DateTime date = await showDatePicker(
            context: context,
            firstDate: DateTime.utc(2010),
            lastDate: DateTime.utc(2025),
            builder: (BuildContext context, Widget? child) {
              return DatePickerTheme(
                data: const DatePickerThemeData(
                  backgroundColor: ThemeColors.gruvLight,
                  dividerColor: ThemeColors.gruvDark,
                  headerForegroundColor: Color.fromARGB(255, 219, 202, 202),
                  shadowColor: ThemeColors.gruvLight,
                  surfaceTintColor: Colors.transparent,
                  yearStyle:
                      TextStyle(color: ThemeColors.gruvDark, fontSize: 14),
                  todayBorder: BorderSide(color: ThemeColors.gruvDark),
                  dayStyle: TextStyle(color: ThemeColors.gruvDark),
                  weekdayStyle: TextStyle(color: ThemeColors.gruvDark),
                  headerHelpStyle:
                      TextStyle(color: ThemeColors.gruvDark, fontSize: 16),
                  headerHeadlineStyle:
                      TextStyle(color: ThemeColors.gruvDark, fontSize: 16),
                  cancelButtonStyle: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll(ThemeColors.gruvDark)),
                  confirmButtonStyle: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll(ThemeColors.gruvDark)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                child: child ?? const SizedBox(),
              );
            },
          ) ??
          DateTime(1900);
      debugPrint(date.toString());
    },
    () {},
  ]);
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
