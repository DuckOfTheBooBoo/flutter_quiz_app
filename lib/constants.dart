import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/quiz_result.dart';

const TextStyle quizHeaderStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 32.0);

const TextStyle quizQuestionStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);

const TextStyle quizAnswerStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 18.0,
);

typedef ResultData = List<QuizResult>;
typedef QuizMap = Map<String, dynamic>;
typedef QuizAnswerMap = Map<String, QuizMap>;
typedef QuizNameMap = Map<String, QuizAnswerMap>;
