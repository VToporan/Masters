import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';
import 'package:note_taking/components/handwriting.dart';
import 'package:note_taking/components/pageMenu.dart';
import 'package:note_taking/components/textbox.dart';
import 'package:note_taking/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 4,
            right: MediaQuery.of(context).size.width / 4,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const TextField(
                cursorColor: ThemeColors.gruvDark,
                style: TextStyle(
                  color: ThemeColors.gruvDark,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.gruvDark,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hoverColor: ThemeColors.gruvDark,
                  focusColor: ThemeColors.gruvDark,
                  fillColor: ThemeColors.gruvDark,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              const TextField(
                cursorColor: ThemeColors.gruvDark,
                style: TextStyle(
                  color: ThemeColors.gruvDark,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hoverColor: ThemeColors.gruvPink,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: const MaterialStatePropertyAll(
                    ThemeColors.gruvDark,
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Colors.transparent,
                  ),
                  shadowColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  surfaceTintColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  fixedSize: MaterialStatePropertyAll(
                    Size(MediaQuery.of(context).size.width / 5,
                        MediaQuery.of(context).size.height / 20),
                  ),
                  shape: const MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      side: BorderSide(
                        color: ThemeColors.gruvDark,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  debugPrint("Login");
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: ThemeColors.gruvDark,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
