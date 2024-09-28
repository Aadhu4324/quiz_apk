import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_apk/api/question_model.dart';
import 'package:quiz_apk/api/quiz_services.dart';
import 'package:quiz_apk/reusbalecomponents/quiz_answer_button.dart';

import 'package:quiz_apk/screens/result_screen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late Future<List<Question>?> list;
  QuizServices services = QuizServices();
  int seconds = 60;
  Timer? timer;
  int _question = 0;
  List answerslist = [];
  bool _isLoaded = false;
  int correctanswers = 0;
  int incorrectanswers = 0;
  List<Color> colors = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    list = services.getQuizData();
    startTimer();
  }

  gotoNextQuestion() {
    seconds = 60;

    _question++;
    _isLoaded = false;
    resetColors();
    timer!.cancel();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            gotoNextQuestion();
          }
        });
      }
    });
  }

  resetColors() {
    colors = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff0f2027),
            Color(0xff203a43),
            Color(0xff2c5364)
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    seconds.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      value: seconds / 60,
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/bulb.png",
                height: 200,
                width: 200,
              ),
              FutureBuilder(
                future: list,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      if (_isLoaded == false) {
                        answerslist =
                            snapshot.data![_question].incorrect_answers!;

                        answerslist
                            .add(snapshot.data![_question].correct_answer);
                        _isLoaded = true;
                        answerslist.shuffle();
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Question ${_question + 1} of ${snapshot.data!.length}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            snapshot.data![_question].question.toString(),
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: answerslist.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                setState(() {
                                  if (answerslist[index] ==
                                      snapshot.data![_question].correct_answer
                                          .toString()) {
                                    colors[index] = Colors.green;

                                    correctanswers++;
                                  } else {
                                    incorrectanswers++;
                                    colors[index] = Colors.red;
                                  }
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 1), () {});

                                if (_question == snapshot.data!.length - 1) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    customroute(ResultScreen(
                                        correctanswer: correctanswers,
                                        incorrectanswer: incorrectanswers,
                                        length: snapshot.data!.length)),
                                    (route) => false,
                                  );
                                } else {
                                  gotoNextQuestion();
                                }
                              },
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: colors[index],
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: Text(
                                  answerslist[index],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Error${snapshot.error}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  }
                },
              )
            ],
          )),
    );
  }
}
