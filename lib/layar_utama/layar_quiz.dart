import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_rupiah/index.dart';
import 'package:provider/provider.dart';

import '../quiz/quiz.dart';
import '../quiz/result.dart';

class LayarQuiz extends StatefulWidget {
  @override
  State<LayarQuiz> createState() => _LayarQuizState();
}

class _LayarQuizState extends State<LayarQuiz> {
  List dataUang = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String response =
        await rootBundle.loadString('assets/data/uang.json');
    final data = await json.decode(response);
    var dataUang_ = [];
    for (var i = 0; i < data.length; i++) {
      var item = data[i];
      if (item['tipe'] == 'Khusus') break;
      var uang = Uang(item['nominal'], item['tipe'], item['judul']);
      dataUang_.add(uang);
    }
    setState(() {
      dataUang = dataUang_;
    });
  }

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
    if (dataUang.isEmpty) {
      return Center(
        child: Text('Loading'),
      );
    }
    var state = context.watch<IndexState>();
    var quiz = state.getQuiz();
    var questions = [];
    var id = Random().nextInt(dataUang.length);
    var uangRandom = dataUang.removeAt(id);
    var idPengecoh = Random().nextInt(dataUang.length);
    var pengecoh = dataUang[idPengecoh];
    questions.add({
      'questionText':
        uangRandom.judul,
      'answers': [
        {'text': id,'score': -2,},
        {'text': idPengecoh, 'score': 10},
      ],
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kuis Uang Rupiah ${quiz.judul}'),
          backgroundColor: quiz.warna,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: questions,
            )
          : Result(_totalScore, _resetQuiz),
        ),
      ),
    );
  }
}

class Uang {
  int nominal;
  String tipe;
  String judul;
  Uang(this.nominal, this.tipe, this.judul);
}