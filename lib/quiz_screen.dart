import 'dart:ui';

import 'package:flutter/material.dart';
import 'custom_appbar.dart';

const TextStyle quizHeaderStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 32.0);

const TextStyle quizButtonTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13.0);

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

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          // TODO: make border thicker
          side: const BorderSide(width: 2),
        ),
      ),
      child: Text(
        text,
        style: quizButtonTextStyle,
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
  final List<Map<String, dynamic>> options = [
    {
      'title': 'Answer 1',
      'selected': false,
    },
    {
      'title': 'Answer 2',
      'selected': false,
    },
    {
      'title': 'Answer 3',
      'selected': false,
    },
    {
      'title': 'Answer 4',
      'selected': false,
    },
  ];

  var selectedAnswer;

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
            Column(
              children: options.map((Map<String, dynamic> option) {
                return ListTile(
                  onTap: () {},
                  title: Text(
                    option['title'],
                    style: quizAnswerStyle,
                  ),
                  leading: Radio(
                    value: option['title'],
                    groupValue: options,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
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
