import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_taking/components/card.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/slidable.dart';
import 'package:note_taking/pages/home.dart';
import 'package:note_taking/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  Event(
    this.timeStamp,
    this.text,
    this.image,
  );
  final String timeStamp;
  final String text;
  final String image;
}

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
  late List<Event> events;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  Future<List<Event>> _getEventsForDay(DateTime day) async {
    List<Event> events = [];
    String dateFromated = DateFormat('yyyy-MM-dd').format(day);
    String userID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/$userID/calendar');
    DataSnapshot times = await ref.child(dateFromated).get();

    if (!times.exists) return [];

    var json = times.value as Map;

    for (var timeStamp in json.keys) {
      Map<Object?, Object?> entry = json[timeStamp.toString()]!;
      events.add(Event(
          timeStamp, entry["text"].toString(), entry["image"].toString()));
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TableCalendar(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    FutureBuilder(
                      future: _getEventsForDay(_selectedDay),
                      builder: (context, future) {
                        if (!future.hasData || future.data!.isEmpty) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 100),
                            child: CardComponent(
                              title: "No entries for this date",
                              subTitle: "",
                              imageString: "",
                              onTap: () {},
                            ),
                          );
                        } else {
                          events = future.data!;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              Event event = events[index];
                              return SlidableComponent(
                                cardTitle: event.timeStamp,
                                cardSubtitle: event.text,
                                cardImageString: event.image,
                                onTap: () async {
                                  String date = DateFormat('yyyy-MM-dd')
                                      .format(_selectedDay);
                                  String time = event.timeStamp;
                                  String accessPoint = 'calendar/$date/$time';
                                  HomePage.of(context)
                                      ?.updateLatestAccess(accessPoint);
                                  HomePage.of(context)?.updateNotesValues(
                                      event.image, event.text);
                                  HomePage.of(context)?.gotoNotes();
                                },
                                onDelete: (context) {
                                  String date = DateFormat('yyyy-MM-dd')
                                      .format(_selectedDay);
                                  String time = event.timeStamp;
                                  String accessPoint = 'calendar/$date/$time';

                                  String userID =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  DatabaseReference ref = FirebaseDatabase
                                      .instance
                                      .ref('users/$userID/$accessPoint');
                                  ref.remove();
                                  setState(() {
                                    events.remove(event);
                                  });
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
