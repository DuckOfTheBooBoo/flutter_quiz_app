import 'dart:convert';
import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/utils/shared_preferences_util.dart';
import '../components/custom_appbar.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../model/question.dart';
import '../model/quiz_result.dart';
import '../screens/result_screen.dart';

class QuizArguments {
  final String quizName;

  QuizArguments({required this.quizName});
}

class QuizScreen extends StatefulWidget {
  static const String routeName = '/quiz';

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();

  Map<String, QuizResult> quizResult = {};

  void _previousPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  void resetState() {
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as QuizArguments;
    return FutureBuilder(
        future: getQuestions(args.quizName.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Question> questions = snapshot.data!;

            // Shuffle question
            questions.shuffle();

            // Create placeholder inside quizResult
            for (var question in snapshot.data!) {
              quizResult[question.id] = QuizResult(
                question: question,
                correctAnswer: question.correctAnswer,
                selectedAnswer: null,
              );
            }

            return Scaffold(
              // TODO: fix back button icon not loaded
              appBar: CustomAppBar(title: args.quizName),
              body: WillPopScope(
                onWillPop: () async {
                  return await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: AlertDialog(
                        title: const Text('You\'re leaving the quiz'),
                        content: const Text(
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => QuizCard(
                    quizName: args.quizName,
                    questions: questions,
                    question: snapshot.data![index],
                    questionLength: snapshot.data!.length,
                    index: index,
                    previousCard: _previousPage,
                    nextCard: _nextPage,
                    quizResult: quizResult,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return SafeArea(
              child: Scaffold(
                body: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class QuizCard extends StatefulWidget {
  final String quizName;
  final List<Question> questions;
  final Question question;
  final int questionLength, index;
  final VoidCallback previousCard;
  final VoidCallback nextCard;
  Map<String, QuizResult> quizResult;

  QuizCard({
    super.key,
    required this.quizName,
    required this.question,
    required this.questionLength,
    required this.index,
    required this.previousCard,
    required this.nextCard,
    required this.quizResult,
    required this.questions,
  });

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard>
    with AutomaticKeepAliveClientMixin<QuizCard> {
  String? _selectedAnswer;

  void _handleAnswerChange(String? value) {
    setState(() {
      _selectedAnswer = value;
      String questionId = widget.question.id;
      // widget.quizResult[questionId] = {
      //   "correct_answer": widget.question.correctAnswer,
      //   "selected_answer": _selectedAnswer
      // };
      widget.quizResult[questionId]?.selectedAnswer = _selectedAnswer;
    });
  }

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
                                onChanged: _handleAnswerChange,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              // Show next if quiz card is not the last, else show submit
                              child: widget.index + 1 != widget.questionLength
                                  ? RoundedButton(
                                      text: 'Next',
                                      onPressed: widget.nextCard,
                                    )
                                  : RoundedButton(
                                      text: 'Submit',
                                      onPressed: () {
                                        // Create QuizNameMap e.g.
                                        //"Linux": {
                                        //    int: quizResult.toMap()
                                        // }
                                        QuizNameMap quizNameMap = {};

                                        QuizAnswerMap answerMap = widget
                                            .quizResult
                                            .map((questionId, quizResult) =>
                                                MapEntry(questionId.toString(),
                                                    quizResult.toMap()));

                                        String answersJson =
                                            SharedPrefs.getString("answers")!;

                                        Map<String, dynamic> answersMap =
                                            jsonDecode(answersJson);

                                        answersMap[widget.quizName] =
                                            answerMap;

                                        // Encode to JSON String
                                        answersJson = jsonEncode(answersMap);

                                        SharedPrefs.setString(
                                                "answers", answersJson)
                                            .then((_) {
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   ResultScreen.routeName,
                                          //   arguments: ResultArguments(
                                          //       widget.quizName,
                                          //       widget.questions,
                                          //       widget.quizResult),
                                          // );
                                          Navigator.pushNamed(
                                            context,
                                            ResultScreen.routeName,
                                            arguments: ResultArguments(
                                                widget.quizName),
                                          );
                                        });
                                      },
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
                    padding: const EdgeInsets.symmetric(vertical: 15),
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

  @override
  bool get wantKeepAlive => true;
}
