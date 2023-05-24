import 'package:flutter/material.dart';
import 'package:game_rupiah/index.dart';
import 'package:game_rupiah/layar_utama/menu_utama.dart';
import 'package:game_rupiah/models/dompet.dart';
import 'package:provider/provider.dart';

class Result extends StatefulWidget {
  final Kuis kuis;
  final int resultScore;
  final Function resetHandler;

  final Dompet dompet;

  const Result(
    this.kuis
    , this.resultScore
    , this.resetHandler
    , {Key? key, required this.dompet}
  )
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
  void initState() {
    super.initState();
    if (widget.resultScore >= 10) {
      widget.dompet.read().then((dompet) {
        setState(() {
          dompet.uang.add(Uang(widget.kuis.rewardId, Pos(0, 0)));
          dompet.write();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<IndexState>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 32.0, 0, 8.0),
            child: Text(
              resultPhrase,
              style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ),
          widget.resultScore >= 10 ? Container(
            margin: EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
            child: Image(
              height: 72,
              image: AssetImage(
                'assets/images/uang/uang-${widget.kuis.rewardId}.png'
              )
            ),
          ) :  Container(
            margin: EdgeInsets.all(16.0),
            child: Text('Coba lagi!', textScaleFactor: 2,)
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)
              ),
              onPressed: () {
                state.reset();
              },
              child:  Text(
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
