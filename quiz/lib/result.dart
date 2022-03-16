import 'package:flutter/material.dart';
import 'package:quizapp/firstassignment.dart';

class Result extends StatelessWidget {
  final int result;
  final Function resetHandler;

  Result({required this.result, required this.resetHandler});

  String get resultPhrase {
    var phrase = 'You Completed it.';
    if (result <= 8) {
      phrase = 'You are awesome and inoncent!';
    } else if (result <= 12) {
      phrase = 'Pretty Likeable!';
    } else if (result <= 16) {
      phrase = 'You are Bad!';
    } else {
      phrase = 'You are strange Indeed!';
    }
    return phrase;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          ElevatedButton(
              onPressed: () {
                resetHandler();
              },
              child: Text('Reset')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Assignment()));
              },
              child: Text('Goto Assignment'))
        ],
      ),
    );
  }
}
