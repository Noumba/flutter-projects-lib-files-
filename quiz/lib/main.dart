import 'package:flutter/material.dart';
import 'package:quizapp/result.dart';
import './quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Quiz App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _questionIndex = 0;
  int _result = 0;
  void _answerQuestion(int score) {
    _result = _result + score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _result = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _questions = [
      {
        'question': 'What\'s your favourite color?',
        'answer': [
          {'text': 'Red', 'score': 10},
          {'text': 'White', 'score': 1},
          {'text': 'Blue', 'score': 5},
          {'text': 'Brown', 'score': 2}
        ]
      },
      {
        'question': 'What\'s your favourite animal?',
        'answer': [
          {'text': 'Rat', 'score': 10},
          {'text': 'Elephant', 'score': 5},
          {'text': 'Leopard', 'score': 1},
          {'text': 'Lion', 'score': 1}
        ]
      },
      {
        'question': 'What\'s your favourite nickname?',
        'answer': [
          {'text': 'Vinci', 'score': 1},
          {'text': 'Einstein', 'score': 2},
          {'text': 'Leonardo', 'score': 3},
          {'text': 'Fabulous', 'score': 4}
        ]
      },
    ];
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions)
              : Result(result: _result, resetHandler: _resetQuiz),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
