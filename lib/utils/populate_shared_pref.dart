import 'package:flutter_quiz_app/constants.dart';
import 'dart:convert';
import 'shared_preferences_util.dart';
import 'package:flutter_quiz_app/model/quiz.dart';

Future<void> populateSharedPrefs() async {
  QuizMap emptyQuizMap = {};
  for (Quiz quiz in quizez) {
    emptyQuizMap[quiz.name] = {};
  }
  
  SharedPrefs.setString("answers", jsonEncode(emptyQuizMap));
}
