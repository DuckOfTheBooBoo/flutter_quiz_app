import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart'
    show QuizArguments, QuizScreen;
import 'package:flutter_quiz_app/screens/result_screen.dart'
    show ResultArguments, ResultScreen;
import 'screens/main_screen.dart';

// TODO: Redo DevOps questions, some of it contains kubernetes
// TODO: Splits programming into multiple languages
// TODO: If back action is triggered in result screen, route to main screen

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
        QuizScreen.routeName: (context) => const QuizScreen(),
        ResultScreen.routeName: (context) => ResultScreen(),
      },
      title: 'Quiz App',
      home: const MainScreen(),
    );
  }
}
