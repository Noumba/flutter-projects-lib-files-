import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function answerHandler;
  final String answer;

  const Answer(this.answerHandler, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  Size.fromWidth(MediaQuery.of(context).size.width * 0.5))),
          onPressed: () {
            answerHandler();
          },
          child: Text(answer)),
    );
  }
}
