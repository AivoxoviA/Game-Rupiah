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
    if (widget.resultScore >= 41) {
      resultText = 'You are awesome!';
    } else if (widget.resultScore >= 31) {
      resultText = 'Pretty likeable!';
    } else if (widget.resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (widget.resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
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
          ), //Text
          Text(
            'Score ' '${widget.resultScore}',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
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
