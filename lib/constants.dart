import 'package:flutter/material.dart';
import 'model/question.dart';

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

typedef AnswerMap = Map<String, String?>;
typedef QuizResultMap = Map<int, AnswerMap>;
typedef ResultData = List<Map<String, dynamic>>;
