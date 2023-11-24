import 'package:flutter_quiz_app/constants.dart';
import 'package:flutter_quiz_app/model/question.dart' show Question;

class QuizResult {
  Question question;
  String correctAnswer;
  String? selectedAnswer;
  QuizResult({
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
  });

  factory QuizResult.fromMap(QuizMap quizMap) => QuizResult(
      question: Question.fromMap(quizMap["question"]),
      correctAnswer: quizMap["correctAnswer"],
      selectedAnswer: quizMap["selectedAnswer"],);

  Map<String, dynamic> toMap() => {
        "question": question.toMap(),
        "correctAnswer": correctAnswer,
        "selectedAnswer": selectedAnswer,
      };
}
