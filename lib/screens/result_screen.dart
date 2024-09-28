import 'package:flutter/material.dart';
import 'package:quiz_apk/reusbalecomponents/quiz_answer_button.dart';
import 'package:quiz_apk/screens/screen_home.dart';

class ResultScreen extends StatelessWidget {
  final int correctanswer;
  final int incorrectanswer;
  final int length;

  const ResultScreen({
    super.key,
    required this.correctanswer,
    required this.incorrectanswer,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff0f2027),
          Color(0xff203a43),
          Color(0xff2c5364)
        ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Congratulations",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "${(correctanswer * 100) / length}%",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Correct Answers : $correctanswer",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Text("InCorrect Answers : $incorrectanswer",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
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
                      "Try Again",
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
      )),
    );
  }
}
