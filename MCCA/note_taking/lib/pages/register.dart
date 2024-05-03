import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/fancyButton.dart';
import 'package:note_taking/components/inputField.dart';
import 'package:note_taking/pages/home.dart';
import 'package:note_taking/theme.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  late String errorText;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    errorText = "";
  }

  @override
  Widget build(BuildContext context) {
    double optimalWidth = MediaQuery.of(context).size.height / 3;
    double optimalHeight = MediaQuery.of(context).size.height / 15;
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputField(
                textController: emailController,
                textFocus: FocusNode(),
                textHidden: false,
                textLabel: "Email",
                textSize: Size(
                  optimalWidth,
                  optimalHeight,
                ),
              ),
              SizedBox(height: optimalHeight / 4),
              InputField(
                textController: passwordController,
                textFocus: FocusNode(),
                textHidden: true,
                textLabel: "Password",
                textSize: Size(
                  optimalWidth,
                  optimalHeight,
                ),
              ),
              SizedBox(height: optimalHeight / 4),
              InputField(
                textController: passwordConfirmController,
                textFocus: FocusNode(),
                textHidden: true,
                textLabel: "Confirm Password",
                textSize: Size(
                  optimalWidth,
                  optimalHeight,
                ),
              ),
              SizedBox(height: optimalHeight / 2),
              Text(
                errorText,
                style:
                    const TextStyle(color: ThemeColors.gruvRed, fontSize: 16),
              ),
              SizedBox(height: optimalHeight / 2),
              FancyButton(
                buttonSize: Size(optimalWidth, optimalHeight * (3 / 4)),
                buttonText: "Register",
                onPressed: () async {
                  if (passwordController.text !=
                      passwordConfirmController.text) {
                    setState(() {
                      errorText = "Passwords don't match.";
                    });
                  } else {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        errorText = e.toString();
                      });
                    }
                  }
                },
              ),
              SizedBox(height: optimalHeight / 4),
              FancyButton(
                buttonSize: Size(optimalWidth, optimalHeight * (3 / 5)),
                buttonText: "Go to Login",
                onPressed: () async {
                  HomePage.of(context)?.gotoLogin();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
