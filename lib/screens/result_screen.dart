import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart';
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import 'package:flutter_quiz_app/components/quiz_box.dart';
import 'package:flutter_quiz_app/components/rounded_button.dart';
import 'package:flutter_quiz_app/constants.dart';
import 'package:flutter_quiz_app/model/question.dart';
import 'package:flutter_quiz_app/model/quiz_result.dart';

class ResultArguments {
  final String quizName;
  ResultArguments(this.quizName);
}

class ResultScreen extends StatelessWidget {
  static const String routeName = '/result';
  int correctAnswerCount = 0;
  ResultData resultData = [];

  ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ResultArguments;
    final String quizName = args.quizName;

    // Get quiz results from shared preferences
    final String quizResultsJson = SharedPrefs.getString("answers")!;
    var quizNameMap = jsonDecode(quizResultsJson);
    final Map<String, dynamic> quizResultsMap = quizNameMap[quizName]!;
    final List<Question> questions = [];
    final Map<String, QuizResult> quizResults = {};

    for (String key in quizResultsMap.keys) {
      QuizResult quizResult = QuizResult.fromMap(quizResultsMap[key]!);
      quizResults[key] = quizResult;
      questions.add(quizResult.question);

      // Calculate amount of correct and wrong
      if (quizResult.selectedAnswer == quizResult.correctAnswer) {
        correctAnswerCount++;
      }
      resultData.add(quizResult);
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = MediaQuery.of(context).size.width;

          return SafeArea(
            child: WillPopScope(
              onWillPop: () async {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/'),
                );
                return false;
              },
              child: screenWidth >= 830
                  ? ResultLandscapeMode(
                      correctAnswerCount: correctAnswerCount,
                      questions: questions,
                      quizName: quizName,
                      resultData: resultData)
                  : ResultPotraitMode(
                      correctAnswerCount: correctAnswerCount,
                      questions: questions,
                      quizName: quizName,
                      resultData: resultData),
            ),
          );
        },
      ),
    );
  }
}

class ResultPotraitMode extends StatelessWidget {
  const ResultPotraitMode({
    super.key,
    required this.correctAnswerCount,
    required this.questions,
    required this.quizName,
    required this.resultData,
  });

  final int correctAnswerCount;
  final List<Question> questions;
  final String quizName;
  final ResultData resultData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Upper segment
          Column(
            children: [
              // 1st upper segment (text)
              const SizedBox(
                height: 15.0,
              ),
              Column(
                children: [
                  const Text(
                    'You\'ve answered',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                        ),
                  ),
                  Text(
                    '$correctAnswerCount/${questions.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 64,
                        fontWeight: FontWeight.bold
                        ),
                  ),
                  const Text(
                    'correctly!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                        ),
                  ),
                ],
              ),
              // 2nd upper segment (buttons)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Row(
                  children: [
                    // Try Again button
                    Expanded(
                      child: RoundedButton(
                        text: 'Try Again',
                        onPressed: () {
                          String answersJson =
                              SharedPrefs.getString("answers")!;
                          Map<String, dynamic> answersMap =
                              jsonDecode(answersJson);

                          answersMap[quizName] = {};

                          SharedPrefs.setString(
                                  "answers", jsonEncode(answersMap))
                              .then((_) {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName('/'),
                            );
                            Navigator.pushNamed(
                              context,
                              QuizScreen.routeName,
                              arguments: QuizArguments(quizName: quizName),
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    // Back to Home button
                    Expanded(
                      child: RoundedButton(
                        text: 'Back to Home',
                        onPressed: () => Navigator.popUntil(
                          context,
                          ModalRoute.withName('/'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Lower segment
          Container(
            // Header
            alignment: Alignment.topLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Review',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                    ),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: resultData.length,
            itemBuilder: (context, index) => ResultQuizBox(
              data: resultData[index],
              index: index,
            ),
          ),
        ],
      ),
    );
  }
}

class ResultLandscapeMode extends StatelessWidget {
  final int correctAnswerCount;
  final List<Question> questions;
  final String quizName;
  final ResultData resultData;
  const ResultLandscapeMode({
    super.key,
    required this.correctAnswerCount,
    required this.questions,
    required this.quizName,
    required this.resultData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You\'ve answered',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.bold
                          ),
                    ),
                    Text(
                      '$correctAnswerCount/${questions.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 128,
                          fontWeight: FontWeight.bold
                          ),
                    ),
                    const Text(
                      'correctly!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.bold
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Row(
                    children: [
                      // Try Again button
                      Expanded(
                        child: RoundedButton(
                          text: 'Try Again',
                          onPressed: () async {
                            String answersJson =
                                SharedPrefs.getString("answers")!;
                            Map<String, dynamic> answersMap =
                                jsonDecode(answersJson);

                            answersMap[quizName] = {};

                            SharedPrefs.setString(
                                    "answers", jsonEncode(answersMap))
                                .then((_) {
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              );
                              Navigator.pushNamed(
                                context,
                                QuizScreen.routeName,
                                arguments: QuizArguments(quizName: quizName),
                              );
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      // Back to Home button
                      Expanded(
                        child: RoundedButton(
                          text: 'Back to Home',
                          onPressed: () => Navigator.popUntil(
                            context,
                            ModalRoute.withName('/'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  // Header
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Review',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: resultData.length,
                      itemBuilder: (context, index) => ResultQuizBox(
                        data: resultData[index],
                        index: index,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
