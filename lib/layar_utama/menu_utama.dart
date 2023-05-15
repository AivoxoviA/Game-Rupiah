import 'package:flutter/material.dart';
import 'package:game_rupiah/index.dart';
import 'package:provider/provider.dart';

class MenuUtama extends StatefulWidget {
  @override
  State<MenuUtama> createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  OutlinedButton _buildButtonColumn(
      BuildContext ctx, Color color, AssetImage img, String label) {
    var state = ctx.watch<IndexState>();
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 0.5, color: Color.fromARGB(255, 190, 19, 96)),
        shape: BeveledRectangleBorder(),
      ),
      onPressed: () {
        state.up();
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: img,
              height: 64,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
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
                    margin: EdgeInsets.all(8.0),
                    color: Colors.green,
                    child: Expanded(
                        child: _buildButtonColumn(
                            context,
                            Colors.white,
                            AssetImage(
                                'assets/images/main_menu/main_menu_0.png'),
                            'Nominal')),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Color.fromARGB(255, 123, 129, 4),
                    margin: EdgeInsets.all(8.0),
                    child: Expanded(
                        child: _buildButtonColumn(
                            context,
                            Colors.white,
                            AssetImage(
                                'assets/images/main_menu/main_menu_1.png'),
                            'Gambar')),
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
                      color: Color.fromARGB(255, 165, 94, 0),
                      margin: EdgeInsets.all(8.0),
                      child: _buildButtonColumn(
                          context,
                          Colors.white,
                          AssetImage('assets/images/main_menu/main_menu_2.png'),
                          '+/-'),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      color: Color.fromARGB(255, 159, 2, 2),
                      margin: EdgeInsets.all(8.0),
                      child: _buildButtonColumn(
                          context,
                          Colors.white,
                          AssetImage('assets/images/main_menu/main_menu_3.png'),
                          '×/÷'),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
