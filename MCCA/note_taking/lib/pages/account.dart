import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_taking/components/fancyButton.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
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
              FancyButton(
                buttonSize: Size(optimalWidth, optimalHeight * (3 / 4)),
                buttonText: "Log Out",
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
              SizedBox(height: optimalHeight / 4),
            ],
          ),
        ),
      ],
    );
  }
}
