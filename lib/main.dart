import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart'
    show QuizScreen;
import 'package:flutter_quiz_app/screens/result_screen.dart'
    show ResultScreen;
import 'screens/main_screen.dart';

// TODO: If back action is triggered in result screen, route to main screen
// TODO: Shuffles question each try

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
