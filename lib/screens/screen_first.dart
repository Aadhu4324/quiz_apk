import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_apk/reusbalecomponents/quiz_answer_button.dart';
import 'package:quiz_apk/screens/screen_home.dart';

class ScreenFirst extends StatelessWidget {
  const ScreenFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff2980b9), Color(0xff2c3e50)])),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                "assets/download.png",
              )),
              Text(
                "Welcome to our",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "Quiz App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Enjoy Playing the Quiz as the Same Time gaining Knowledge as Well!!",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(customroute(ScreenHome()));
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(250)),
                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
