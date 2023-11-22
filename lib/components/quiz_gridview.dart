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
              (quiz) => QuizGridCard(quiz: quiz),
            )
            .toList(),
      ),
    );
  }
}

class QuizGridCard extends StatelessWidget {
  final Quiz quiz;
  const QuizGridCard({Key? key, required this.quiz}) : super(key: key);

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
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            side: BorderSide(color: Colors.black, width: 2.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  quiz.imageAsset,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('10 questions')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
