import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart'
    show QuizArguments, QuizScreen;
import 'package:flutter_quiz_app/screens/result_screen.dart'
    show ResultArguments, ResultScreen;
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        QuizScreen.routeName: (context) => QuizScreen(),
        ResultScreen.routeName: (context) => ResultScreen(),
      },
      title: 'Quiz App',
      home: MainScreen(),
    );
  }
}
