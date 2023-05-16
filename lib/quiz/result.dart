import 'package:flutter/material.dart';
import 'package:game_rupiah/index.dart';
import 'package:provider/provider.dart';

class Result extends StatefulWidget {
  final int resultScore;
  final Function resetHandler;

  const Result(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String get resultPhrase {
    String resultText;
    if (widget.resultScore >= 10) {
      resultText = 'Yaayyy, kamu dapat hadiah!';
    } else {
      resultText = 'yahhh...';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<IndexState>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          widget.resultScore == 10 ? Image(
            height: 128,
            image: AssetImage('assets/images/uang/uang-26.png')
          ) :  Container(
            margin: EdgeInsets.all(16.0),
            child: Text('Coba lagi!', textScaleFactor: 2,)
          ),
          TextButton(
            onPressed: () {
              state.reset();
            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
