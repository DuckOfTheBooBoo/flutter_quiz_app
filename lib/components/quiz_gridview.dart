import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/quiz.dart' show Quiz;
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import 'package:flutter_quiz_app/screens/result_screen.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart';
import 'dart:convert';

class QuizGridView extends StatelessWidget {
  final List<Quiz> quizez;
  final int gridCount;
  QuizGridView({Key? key, required this.quizez, required this.gridCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        children: quizez
            .map(
              (quiz) => QuizGridStack(quiz: quiz),
            )
            .toList(),
      ),
    );
  }
}

class QuizGridStack extends StatelessWidget {
  final Quiz quiz;
  const QuizGridStack({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String answersJson = SharedPrefs.getString("answers")!;

        Map<String, dynamic> answersMap = jsonDecode(answersJson);

        Map<dynamic, dynamic> quizMap = answersMap[quiz.name]!;

        if (quizMap.isNotEmpty) {
          Navigator.pushNamed(context, ResultScreen.routeName,
              arguments: ResultArguments(quiz.name));
        } else {
          Navigator.pushNamed(
            context,
            QuizScreen.routeName,
            arguments: QuizArguments(quizName: quiz.name),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  quiz.imageAsset,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(168, 168, 168, 0.8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              quiz.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const Text(
                              '10 questions',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
