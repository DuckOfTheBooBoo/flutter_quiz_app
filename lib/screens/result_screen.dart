import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/screens/quiz_screen.dart';
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../model/question.dart';
import '../model/quiz_result.dart';

class ResultArguments {
  final String quizName;
  // final List<Question> questions;
  // final Map<String, QuizResult> quizResults;

  // ResultArguments(this.quizName, this.questions, this.quizResults);
  ResultArguments(this.quizName);
}

class ResultScreen extends StatelessWidget {
  static const String routeName = '/result';
  int correctAnswerCount = 0;
  ResultData resultData = [];

  ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ResultArguments;
    final String quizName = args.quizName;

    // Get quiz results from shared preferences
    final String quizResultsJson = SharedPrefs.getString("answers")!;
    var quizNameMap = jsonDecode(quizResultsJson);
    print('');
    final Map<String, dynamic> quizResultsMap = quizNameMap[quizName]!;
    final List<Question> questions = [];
    final Map<String, QuizResult> quizResults = {};

    for (String key in quizResultsMap.keys) {
      QuizResult quizResult = QuizResult.fromMap(quizResultsMap[key]!);
      quizResults[key] = quizResult;
      questions.add(quizResult.question);

      // Calculate amount of correct and wrong
      if (quizResult.selectedAnswer == quizResult.correctAnswer) {
        correctAnswerCount++;
      }
      resultData.add(quizResult);
    }

    // for (String key in quizResults.keys) {
    //   QuizResult correctQuizResult = quizResults[key]!;

    // }

    Future<void> _showDialog(BuildContext context) async {
      final String? value = SharedPrefs.getString("answers");

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Shared Preferences'),
              content: Text('$value'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }

    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Upper segment
                Column(
                  children: [
                    // 1st upper segment (text)
                    const SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      children: [
                        const Text(
                          'You\'ve answered',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                        const Text(
                          'correctly!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
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
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: Row(
                        children: [
                          // Try Again button
                          Expanded(
                            child: RoundedButton(
                              text: 'Try Again',
                              onPressed: () {
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName('/'),
                                );
                                Navigator.pushNamed(
                                    context, QuizScreen.routeName,
                                    arguments:
                                        QuizArguments(quizName: quizName));
                              },
                            ),
                          ),
                          const SizedBox(
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
                          Expanded(
                              child: RoundedButton(
                                  text: 'Get SharedPrefs',
                                  onPressed: () {
                                    _showDialog(context);
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
                // Lower segment
                Container(
                  // Header
                  alignment: Alignment.topLeft,
                  child: const Padding(
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
                  physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}

class QuizBox extends StatelessWidget {
  final QuizResult data;
  final int index;

  const QuizBox({
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
