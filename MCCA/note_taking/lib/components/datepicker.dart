    // () async {
    //   DateTime date = await showDatePicker(
    //         context: context,
    //         firstDate: DateTime.utc(2010),
    //         lastDate: DateTime.utc(2025),
    //         builder: (BuildContext context, Widget? child) {
    //           return DatePickerTheme(
    //             data: const DatePickerThemeData(
    //               backgroundColor: ThemeColors.gruvLight,
    //               dividerColor: ThemeColors.gruvDark,
    //               headerForegroundColor: Color.fromARGB(255, 219, 202, 202),
    //               shadowColor: ThemeColors.gruvLight,
    //               surfaceTintColor: Colors.transparent,
    //               yearStyle:
    //                   TextStyle(color: ThemeColors.gruvDark, fontSize: 14),
    //               todayBorder: BorderSide(color: ThemeColors.gruvDark),
    //               dayStyle: TextStyle(color: ThemeColors.gruvDark),
    //               weekdayStyle: TextStyle(color: ThemeColors.gruvDark),
    //               headerHelpStyle:
    //                   TextStyle(color: ThemeColors.gruvDark, fontSize: 16),
    //               headerHeadlineStyle:
    //                   TextStyle(color: ThemeColors.gruvDark, fontSize: 16),
    //               cancelButtonStyle: ButtonStyle(
    //                   foregroundColor:
    //                       MaterialStatePropertyAll(ThemeColors.gruvDark)),
    //               confirmButtonStyle: ButtonStyle(
    //                   foregroundColor:
    //                       MaterialStatePropertyAll(ThemeColors.gruvDark)),
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //             ),
    //             child: child ?? const SizedBox(),
    //           );
    //         },
    //       ) ??
    //       DateTime(1900);
    //   debugPrint(date.toString());
    // },