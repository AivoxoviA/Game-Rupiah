import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            selectHandler();
          },
          style: ButtonStyle(
          textStyle:
            MaterialStateProperty.all(
              const TextStyle(color: Colors.white)
            ),
          backgroundColor: MaterialStateProperty.all(Colors.green)),
          child: SizedBox(
            height: 64,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/uang/uang-$answerText'
              )
            )
          ),
        ),
      ),
    );
  }
}
