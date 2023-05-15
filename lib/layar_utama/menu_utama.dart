import 'package:flutter/material.dart';

class MenuUtama extends StatelessWidget {
  OutlinedButton _buildButtonColumn(Color color, AssetImage img, String label) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 0.5, color: Color.fromARGB(255, 190, 19, 96)),
        shape: BeveledRectangleBorder(),
      ),
      onPressed: () {},
      child: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(icon, color: color, size: 72),
            Image(
              image: img,
              height: 64,
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
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
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Expanded(
                      child: _buildButtonColumn(
                        color, AssetImage(
                          'assets/images/main_menu/main_menu_0.png'
                        ), 'Tebak Nominal'
                      )
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: Expanded(
                      child: _buildButtonColumn(
                        color, AssetImage(
                          'assets/images/main_menu/main_menu_1.png'
                        ), 'Tebak Gambar'
                      )
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
                    margin: EdgeInsets.all(16.0),
                    child: _buildButtonColumn(
                      color, AssetImage(
                        'assets/images/main_menu/main_menu_2.png'
                      ), 'Tambah Kurang'
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    child: _buildButtonColumn(
                      color, AssetImage(
                        'assets/images/main_menu/main_menu_3.png'
                      ), 'Perkalian Pembagian'
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
