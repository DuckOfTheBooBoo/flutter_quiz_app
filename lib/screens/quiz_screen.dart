import 'dart:ui';
import 'package:flutter/material.dart';
import '../components/custom_appbar.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../model/question.dart';

const List<Map<String, dynamic>> rawQuestions = [
  {
    "id": 1035,
    "question":
        "Which of the following commands will install Ansible on Ubuntu?",
    "answers": {
      "answer_a": "sudo apt install ansible",
      "answer_b": "sudo apt install ansible-controller",
      "answer_c": "sudo apt install ansible-master",
      "answer_d": "sudo apt install ansible-server",
      "answer_e": null,
      "answer_f": null
    },
    "tags": [
      {"name": "DevOps"}
    ],
    "category": "DevOps",
    "difficulty": "Easy",
    "correct_answer": "answer_a"
  },
  {
    "id": 914,
    "question": "The Kubernetes Network proxy runs on which node?",
    "answers": {
      "answer_a": "Master Node",
      "answer_b": "Worker Node",
      "answer_c": "All the nodes",
      "answer_d": "None of the mentioned",
      "answer_e": null,
      "answer_f": null
    },
    "tags": [
      {"name": "Kubernetes"}
    ],
    "category": "DevOps",
    "difficulty": "Easy",
    "correct_answer": "answer_c"
  },
  {
    "id": 899,
    "question":
        "Kubernetes uses _____________ to connect to ouath 2 providers to offload the authentication to external services.",
    "answers": {
      "answer_a": "Webhook Token Authentication",
      "answer_b": "Keystone Password",
      "answer_c": "OpenID Connect Tokens",
      "answer_d": "Authentication Proxy",
      "answer_e": null,
      "answer_f": null
    },
    "tags": [
      {"name": "Kubernetes"}
    ],
    "category": "DevOps",
    "difficulty": "Easy",
    "correct_answer": "answer_c"
  },
  {
    "id": 903,
    "question": "The command to create Kubernetes service is",
    "answers": {
      "answer_a": "kubectl expose",
      "answer_b": "kubectl deploy",
      "answer_c": "kubectl run",
      "answer_d": "kubectl set service",
      "answer_e": null,
      "answer_f": null
    },
    "tags": [
      {"name": "Kubernetes"}
    ],
    "category": "DevOps",
    "difficulty": "Easy",
    "correct_answer": "answer_a"
  }
];

List<Question> questions =
    rawQuestions.map((question) => Question.fromJson(question)).toList();

class QuizScreen extends StatelessWidget {
  // final List<Question> questions;
  final PageController _pageController = PageController();

  void _previousPage() {
    _pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: fix back button icon not loaded
      appBar: CustomAppBar(title: 'Linux'),
      body: WillPopScope(
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
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: questions.length,
          itemBuilder: (context, index) => QuizCard(
            question: questions[index],
            questionLength: questions.length,
            index: index,
            previousCard: _previousPage,
            nextCard: _nextPage,
          ),
        ),
      ),
    );
  }
}

class QuizCard extends StatefulWidget {
  final Question question;
  final int questionLength, index;
  final VoidCallback previousCard;
  final VoidCallback nextCard;
  QuizCard({
    Key? key,
    required this.question,
    required this.questionLength,
    required this.index,
    required this.previousCard,
    required this.nextCard,
  }) : super(key: key);

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  String _selectedAnswer = '';
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${widget.index + 1}',
                      style: quizHeaderStyle,
                    ),
                    Text(
                      widget.question.question,
                      style: quizQuestionStyle,
                    ),
                    // Answers
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: widget.question.answers.keys
                          .where((key) => widget.question.answers[key] != null)
                          .map(
                            (key) => ListTile(
                              title: Text(widget.question.answers[key]),
                              leading: Radio(
                                value: key,
                                groupValue: _selectedAnswer,
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswer = value!;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.0),
                              child: widget.index > 0
                                  ? RoundedButton(
                                      text: 'Previous',
                                      onPressed: widget.previousCard,
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.0),
                              // Show next if quiz card is not the last, else show submit
                              child: widget.index+1 != widget.questionLength
                                  ? RoundedButton(
                                      text: 'Next',
                                      onPressed: widget.nextCard,
                                    )
                                  : RoundedButton(
                                      text: 'Submit',
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
                      '${widget.index + 1}/${widget.questionLength}',
                      style: quizAnswerStyle,
                    ),
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
