import 'package:flutter/material.dart';
import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<dynamic> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 8.0, 0, 24.0),
          child: Text(
            'Pertanyaan ke-${questionIndex+1}/${questions.length}',
            textScaleFactor: 1.2,
          ),
        ),
        Question(
        questions[questionIndex]['questionText'].toString(),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<dynamic, dynamic>>)
          .map((answer) {
        return Answer(
          () => answerQuestion(answer['score']), answer['text'].toString());
        }).toList()
      ],
    );
  }
}
