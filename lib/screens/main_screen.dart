import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import '../model/quiz.dart';
import 'quiz_screen.dart';
import '../components/custom_appbar.dart';
import 'result_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'QUIZ APP'),
      body: MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

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
              Navigator.pushNamed(
                context,
                ResultScreen.routeName,
                arguments: ResultArguments(quiz.name)
              );
            } else {
              Navigator.pushNamed(
                context,
                QuizScreen.routeName,
                arguments: QuizArguments(quizName: quiz.name),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                        )
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
