import 'dart:ui';
import 'package:flutter/material.dart';
import '../components/custom_appbar.dart';
import '../components/rounded_button.dart';
import '../constants.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: fix back button icon not loaded
      appBar: CustomAppBar(title: 'Linux'),
      body: WillPopScope(
        child: QuizContainer(),
        onWillPop: () async {
          return await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: AlertDialog(
                title: Text('You\'re leaving the quiz'),
                content: Text(
                    'Are you sure you want to quit?\nAny answered questions will not be saved!'),
                actions: [
                  RoundedButton(
                    text: 'No',
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  RoundedButton(
                    text: 'Yes',
                    onPressed: () => Navigator.pop(context, true),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // TODO: make border thicker
                  side: const BorderSide(width: 2),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizContainer extends StatefulWidget {
  const QuizContainer({Key? key}) : super(key: key);

  @override
  _QuizContainerState createState() => _QuizContainerState();
}

class _QuizContainerState extends State<QuizContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Quiz(),
          ),
        ),
      ),
    );
  }
}

class QuizQuestion {
  final String question;
  final Map<String, String> options;

  QuizQuestion({required this.question, required this.options});
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // TODO: fix this shit

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question 1',
              style: quizHeaderStyle,
            ),
            Text(
              'Lorem ipsum some question about linux or specific topic haiya chaw ni ma le',
              style: quizQuestionStyle,
            ),
            // Answers

            SizedBox(height: 15),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: RoundedButton(
                        text: 'Previous',
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: RoundedButton(
                        text: 'Next',
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              '1/10',
              style: quizAnswerStyle,
            ),
          ),
        ),
      ],
    );
  }
}
