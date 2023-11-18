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

}
