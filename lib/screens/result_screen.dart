import 'package:flutter/material.dart';
import 'package:collection/collection.dart' show IterableZip;
import '../components/rounded_button.dart';
import '../constants.dart';
import '../model/question.dart';
import './main_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final QuizResultMap quizResult;
  int correctAnswerCount = 0;
  ResultData resultData = [];

  ResultScreen({
    Key? key,
    required this.questions,
    required this.quizResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (Question question in questions) {
      Map<String, dynamic> data = {
        "question": question,
        ...?quizResult[question.id]
      };

      if (quizResult[question.id]?["selected_answer"] ==
          question.correctAnswer) {
        correctAnswerCount++;
      }

      resultData.add(data);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Upper segment
              Container(
                child: Column(
                  children: [
                    // 1st upper segment (text)
                    SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'You\'ve answered',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                              // TODO: Change font family
                              ),
                        ),
                        Text(
                          '$correctAnswerCount/${questions.length}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 64,
                              fontWeight: FontWeight.bold
                              // TODO: Change font family
                              ),
                        ),
                        Text(
                          'correctly!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                              // TODO: Change font family
                              ),
                        ),
                      ],
                    ),
                    // 2nd upper segment (buttons)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0),
                      child: Row(
                        children: [
                          // Try Again button
                          Expanded(
                            child: RoundedButton(
                              text: 'Try Again',
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          // Back to Home button
                          Expanded(
                            child: RoundedButton(
                              text: 'Back to Home',
                              onPressed: () => Navigator.popUntil(
                                context,
                                ModalRoute.withName('/'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Lower segment
              Container(
                // Header
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Review',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                        // TODO: Change font family
                        ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: resultData.length,
                itemBuilder: (context, index) => QuizBox(
                  data: resultData[index],
                  index: index,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizBox extends StatelessWidget {
  final Map<String, dynamic> data;
  final int index;

  const QuizBox({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final int correctColor = 0xFF00FF0A;
  final int correctShadowColor = 0xFF007C04;
  final int wrongColor = 0xFFF73737;
  final int wrongShadowColor = 0xFF5C1717;

  @override
  Widget build(BuildContext context) {
    final Question question = data["question"];
    final String? selectedAnswer = data["selected_answer"];
    final String correctAnswer = data["correct_answer"];
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
