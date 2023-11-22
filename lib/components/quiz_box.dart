import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/constants.dart';
import 'package:flutter_quiz_app/model/question.dart';
import 'package:flutter_quiz_app/model/quiz_result.dart';

class ResultQuizBox extends StatelessWidget {
  final QuizResult data;
  final int index;

  const ResultQuizBox({
    super.key,
    required this.data,
    required this.index,
  });

  final int correctColor = 0xFF00FF0A;
  final int correctShadowColor = 0xFF007C04;
  final int wrongColor = 0xFFF73737;
  final int wrongShadowColor = 0xFF5C1717;

  @override
  Widget build(BuildContext context) {
    final Question question = data.question;
    final String? selectedAnswer = data.selectedAnswer;
    final String correctAnswer = data.correctAnswer;
    final bool isCorrect = selectedAnswer == correctAnswer;

    return Padding(
      padding: const EdgeInsets.only(
        left: 28.0,
        right: 15.0,
        top: 5.0,
        bottom: 17.0,
      ),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: Color(isCorrect ? correctColor : wrongColor),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: [
            BoxShadow(
              color: Color(isCorrect ? correctShadowColor : wrongShadowColor),
              blurRadius: 4,
              offset: const Offset(7, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${index + 1}',
                style: quizHeaderStyle,
              ),
              Text(
                question.question,
                style: quizQuestionStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: question.answers.keys
                    .where((key) => question.answers[key] != null)
                    .map(
                      (key) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: key == correctAnswer
                                ? const Color.fromARGB(184, 7, 245, 15)
                                : const Color.fromARGB(199, 251, 21, 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              question.answers[key],
                              style: TextStyle(
                                  fontWeight: key == correctAnswer
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: key == correctAnswer ? 20 : 16),
                            ),
                            leading: Radio(
                              value: key,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity),
                              groupValue: selectedAnswer,
                              activeColor: Colors.black,
                              onChanged: null,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
