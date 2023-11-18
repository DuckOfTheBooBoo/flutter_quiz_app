import 'package:flutter/material.dart';


const TextStyle quizButtonTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13.0);

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  }) {
    // TODO: implement RoundedButton
    throw UnimplementedError();
  }

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
