import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart' show QuizScreen;
import 'package:flutter_quiz_app/screens/result_screen.dart' show ResultScreen;
import 'package:flutter_quiz_app/utils/populate_shared_pref.dart';
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart'
    show SharedPrefs;
import 'screens/main_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Shared Preferences
  await SharedPrefs.init();
  await populateSharedPrefs();

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
