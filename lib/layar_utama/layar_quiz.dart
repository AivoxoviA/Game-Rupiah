import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_rupiah/index.dart';
import 'package:game_rupiah/models/dompet.dart';
import 'package:provider/provider.dart';

import '../quiz/quiz.dart';
import '../quiz/result.dart';

class LayarQuiz extends StatefulWidget {
  @override
  State<LayarQuiz> createState() => _LayarQuizState();
}

class _LayarQuizState extends State<LayarQuiz> {
  List mapUang = [];
  var questions = [];

  @override
  void initState() {
    super.initState();
    questionsBuilt = false;
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
      var uang = Uang(
        item['nominal']
        , item['tipe']
        , item['judul']
        , item['tipe'] == 'Koin' ? '$i.png' : '$i.jpg'
      );
      dataUang_.add(uang);
    }

    setState(() {
      mapUang = dataUang_;
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

  var questionsBuilt = false;
  @override
  Widget build(BuildContext context) {
    if (mapUang.isEmpty) {
      return Center(
        child: Text('Loading'),
      );
    }
    var state = context.watch<IndexState>();
    var quiz = state.getQuiz();
    if (!questionsBuilt) questions = buildQuestions(quiz);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kuis Uang Rupiah ${quiz.judul}'),
          backgroundColor: quiz.warna,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: _questionIndex < questions.length && _totalScore >= 0
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: questions,
                )
              : Result(quiz, _totalScore, _resetQuiz, dompet: Dompet([])),
            ),
          ],
        ),
      ),
    );
  }
  
  buildQuestions(quiz) {
    var questions = [];
    for (var i = 0; i < quiz.numberOfQuestions; i++) {
      var id = Random().nextInt(mapUang.length);
      var uangRandom = mapUang.removeAt(id);
      mapUang.removeWhere((element) {
        return element.nominal == uangRandom.nominal
          && element.tipe == uangRandom.tipe;
      });
      var idPengecoh = Random().nextInt(mapUang.length);
      var pengecoh = mapUang.elementAt(idPengecoh);
      var answers = [
        {'text': uangRandom.img,'score': 10,},
        {'text': pengecoh.img, 'score': -50},
      ];
      answers.shuffle();
      questions.add({
        'questionText':
          uangRandom.judul,
        'answers': answers,
      });
    }
    questionsBuilt = true;
    return questions;
  }
}

class Uang {
  int nominal;
  String tipe;
  String judul;
  String img;
  Uang(this.nominal, this.tipe, this.judul, this.img);
}