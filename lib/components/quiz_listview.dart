import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/quiz.dart' show Quiz;
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import 'package:flutter_quiz_app/screens/result_screen.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart';
import 'dart:convert';


class QuizListView extends StatelessWidget {
  final List<Quiz> quizez;
  QuizListView({Key? key, required this.quizez,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: quizez.length,
          itemBuilder: (context, index) {
            final Quiz quiz = quizez[index];

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
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  quiz.imageAsset,
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              quiz.name,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '${quiz.questionNum} questions',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
