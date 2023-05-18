import 'package:flutter/material.dart';
import 'package:game_rupiah/index.dart';
import 'package:provider/provider.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);
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
              height: 32,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                quiz.judul,
                style: TextStyle(
                  fontSize: 16,
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
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/main_menu/mudah_sulit.png'),
              height: 48,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children:  [
                Container(
                  color: kuis[0].warna,
                  child: _buildButtonColumn(
                    kuis[0],
                    context,
                  ),
                ),
                Container(
                  color: kuis[1].warna,
                  child: _buildButtonColumn(
                    kuis[1],
                    context,
                  ),
                ),
                Container(
                  color: kuis[2].warna,
                  child: _buildButtonColumn(
                    kuis[2],
                    context,
                  ),
                ),
                Container(
                  color: kuis[3].warna,
                  child: _buildButtonColumn(
                    kuis[3],
                    context,
                  ),
                ),
              ],
            ),
          )
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
