import 'package:flutter/material.dart';

class MenuUtama extends StatelessWidget {
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 72),
        Container(
          margin: const EdgeInsets.only(top: 1),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    List items = [
      _buildButtonColumn(color, Icons.money, 'Tebak Nominal'),
      _buildButtonColumn(color, Icons.photo_size_select_actual_rounded, 'Tebak Gambar'),
      _buildButtonColumn(color, Icons.my_library_add_outlined, 'Tambah Kurang'),
      _buildButtonColumn(color, Icons.one_x_mobiledata, 'Kali bagi'),
    ];
    Widget w = GridView.count(
      crossAxisCount: 2,
      children: List.generate(items.length, (index) {
        return items[index];
      }),
    );
    return w;
  }
}
