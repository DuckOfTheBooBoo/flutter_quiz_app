import 'package:flutter/material.dart';
import 'rounded_button.dart';
import 'styles.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        '4/10',
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
                        SizedBox(width: 15,),
                        // Back to Home button
                        Expanded(
                          child: RoundedButton(
                            text: 'Back to Home',
                            onPressed: () => Navigator.pop(context),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
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
                  ),),
                  QuizBox(
                    isCorrect: true,
                  ),
                  QuizBox(isCorrect: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizBox extends StatelessWidget {
  final bool isCorrect;

  const QuizBox({Key? key, required this.isCorrect}) : super(key: key);

  final int correctColor = 0xFF00FF0A;
  final int correctShadowColor = 0xFF007C04;
  final int wrongColor = 0xFFF73737;
  final int wrongShadowColor = 0xFF5C1717;

  @override
  Widget build(BuildContext context) {
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Question 1',
              style: quizHeaderStyle,
            ),
            Text(
              'Lorem ipsum some question about linux or specific topic haiya chaw ni ma le',
              style: quizQuestionStyle,
            ),
          ]),
        ),
      ),
    );
  }
}
