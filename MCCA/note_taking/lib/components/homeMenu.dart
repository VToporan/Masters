import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:note_taking/theme.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key, required this.menuFunctions});

  final List<VoidCallback> menuFunctions;

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
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
        boxShadow: const [],
        icon: Icons.person,
        onTap: func,
      ));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
      alignment: const Alignment(-1.0, 0.0),
      radius: 80,
      curve: Curves.easeInOutSine,
      reverseCurve: Curves.easeInOutSine,
      toggleButtonOnPressed: () {
        //callback
      },
      // toggle button appearance properties
      toggleButtonColor: ThemeColors.gruvPink,
      toggleButtonIconColor: ThemeColors.gruvLight,
      toggleButtonMargin: 10.0,
      toggleButtonPadding: 10.0,
      toggleButtonSize: 30.0,
      toggleButtonBoxShadow: const [],
      items: buildMenu(),
    );
  }
}