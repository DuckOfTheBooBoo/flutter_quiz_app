import 'package:flutter/material.dart';
import 'model/questions.dart';
import 'custom_appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(
        // TODO: Apply horizontal margin to appbar
        title: const Text(
          'QUIZ APP',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            side: BorderSide(color: Colors.black, width: 2.0)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        padding: EdgeInsets.symmetric(horizontal: 10),
      ),
      body: MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final Question question = questions[index];

        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              question.imageAsset,
                            ),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${question.questionNum} questions',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
