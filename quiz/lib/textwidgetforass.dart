import 'package:flutter/material.dart';

class AssignmentText extends StatelessWidget {
  final String displayedText;
  AssignmentText({required this.displayedText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        displayedText,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
