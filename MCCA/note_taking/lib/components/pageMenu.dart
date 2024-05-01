import 'dart:math';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({super.key, required this.menuFunctions});

  final List<VoidCallback> menuFunctions;

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  @override
  void initState() {
    super.initState();
  }

  List<CircularMenuItem> buildMenu() {
    List<CircularMenuItem> ret = [];
    for (VoidCallback func in widget.menuFunctions) {
      ret.add(CircularMenuItem(
        iconColor: ThemeColors.gruvLight,
        color: ThemeColors.gruvDark,
        icon: Icons.person,
        boxShadow: const [],
        onTap: func,
      ));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      alignment: const Alignment(1.0, 0.5),
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
      toggleButtonBoxShadow: const [],
      toggleButtonMargin: 10.0,
      toggleButtonPadding: 10.0,
      toggleButtonSize: 30.0,
      items: buildMenu(),
    );
  }
}
