import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/components/quiz_gridview.dart';
import 'package:flutter_quiz_app/components/quiz_listview.dart';
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import 'package:flutter_quiz_app/model/quiz.dart';
import 'quiz_screen.dart';
import 'package:flutter_quiz_app/components/custom_appbar.dart';
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size screenSize = MediaQuery.of(context).size;
        int initialGridCount = 2;

        if (screenSize.width >= 500 && screenSize.width < 600) {
          return QuizGridView(
            quizez: quizez,
            gridCount: initialGridCount,
          );
        }

        if (screenSize.width >= 600 && screenSize.width < 700) {
          return QuizGridView(
            quizez: quizez,
            gridCount: initialGridCount + 1,
          );
        }

        if (screenSize.width >= 700 && screenSize.width < 1060) {
          return QuizGridView(
            quizez: quizez,
            gridCount: initialGridCount + 2,
          );
        }

        if (screenSize.width >= 1060) {
          return QuizGridView(
            quizez: quizez,
            gridCount: initialGridCount + 3,
          );
        }

        return QuizListView(quizez: quizez);
      },
    );
  }
}
