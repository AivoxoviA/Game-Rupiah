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
  List mapUang = [];

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

  @override
  Widget build(BuildContext context) {
    if (mapUang.isEmpty) {
      return Center(
        child: Text('Loading'),
      );
    }
    var state = context.watch<IndexState>();
    var quiz = state.getQuiz();
    var questions = [];
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
      {'text': pengecoh.img, 'score': 0},
    ];
    answers.shuffle();
    questions.add({
      'questionText':
        uangRandom.judul,
      'answers': answers,
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
  String img;
  Uang(this.nominal, this.tipe, this.judul, this.img);
}