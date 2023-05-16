import 'package:flutter/material.dart';
import 'package:game_rupiah/index.dart';
import 'package:provider/provider.dart';

class MenuUtama extends StatefulWidget {
  @override
  State<MenuUtama> createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  OutlinedButton _buildButtonColumn(
      quiz, BuildContext ctx) {
    var state = ctx.watch<IndexState>();
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 0.5, color: Color.fromARGB(255, 190, 19, 96)),
        shape: BeveledRectangleBorder(),
      ),
      onPressed: () {
        state.setQuiz(quiz);
        state.up();
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/main_menu/main_menu_${quiz.id}.png'),
              height: 64,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                quiz.judul,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }


  List kuis = [
    Kuis(0, 'Nominal', Color.fromARGB(255, 0, 139, 5)),
    Kuis(1, 'Gambar', Color.fromARGB(255, 130, 115, 0)),
    Kuis(2, '+/-', Color.fromARGB(255, 130, 50, 0)),
    Kuis(3, '×/÷', Color.fromARGB(255, 130, 0, 0)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(
            image: AssetImage('assets/images/main_menu/mudah_sulit.png'),
            height: 48,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(4.0, 64.0, 4.0, 8.0),
                    color: kuis[0].warna,
                    child: Expanded(
                      child: _buildButtonColumn(
                        kuis[0],
                        context,
                      )
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: kuis[1].warna,
                    margin: EdgeInsets.fromLTRB(4.0, 64.0, 4.0, 8.0),
                    child: Expanded(
                      child: _buildButtonColumn(
                        kuis[1],
                        context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: kuis[2].warna,
                    margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 64.0),
                    child: _buildButtonColumn(
                      kuis[2],
                      context,
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: kuis[3].warna,
                    margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 64.0),
                    child: _buildButtonColumn(
                      kuis[3],
                      context,
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Kuis {
  int id;
  String judul;
  Color warna;
  Kuis(this.id, this.judul, this.warna);
}
