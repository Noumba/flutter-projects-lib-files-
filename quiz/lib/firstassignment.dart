import 'package:flutter/material.dart';
import 'package:quizapp/textwidgetforass.dart';

class Assignment extends StatefulWidget {
  Assignment({Key? key}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  int textIndex = 0;

  void _changeText() {
    textIndex += 1;
    setState(() {});
  }

  var textMessage = [
    'Hello, good morning. How are you doing today? Hope you had a splendid night!',
    'Please who are you? My name is Noumba Leonard and am a fresh graduate looking for a job as software developer.',
    'How is the covid-19 situation in your country? What can u say about the deads in you area?',
    'Is there any worst disease or pandemic in your area your fear more than the corona virus?',
    'How do you find the Udemy flutter courses? Is it really interesting to you or give us ur thoughts.',
    'Please how can I improve on my content writing skills? I really want to be a good writer and communicatot.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment Page'),
      ),
      body: textIndex < textMessage.length
          ? Column(
              children: <Widget>[
                AssignmentText(displayedText: textMessage[textIndex]),
                ElevatedButton(
                    onPressed: () {
                      _changeText();
                    },
                    child: Text('Change text'))
              ],
            )
          : Container(
              child: Text(
                'Thanks for answering all our questions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
