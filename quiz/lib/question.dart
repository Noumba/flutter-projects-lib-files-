import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;
  Question(this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: Text(question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            )));
  }
}
