import 'package:flutter/material.dart';
import 'package:game_rupiah/index.dart';
import 'package:provider/provider.dart';

import '../quiz/quiz.dart';
import '../quiz/result.dart';

class LayarQuiz extends StatefulWidget {

  @override
  State<LayarQuiz> createState() => _LayarQuizState();
}

class _LayarQuizState extends State<LayarQuiz> {
  final _questions = const [
    {
      'questionText':
          'Q5. Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];

  var _questionIndex = 0;

  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<IndexState>();
    var quiz = state.getQuiz();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kuis Uang Rupiah ${quiz.judul}'),
          backgroundColor: quiz.warna,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(_totalScore, _resetQuiz),
        ),
      ),
    );
  }
}