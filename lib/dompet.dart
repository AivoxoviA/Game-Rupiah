import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dompet extends StatefulWidget {
  @override
  State<Dompet> createState() => _DompetState();
}

class _DompetState extends State<Dompet> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  List uang = [
    Uang(26, XY(0, 0)),
  ];
  List _dataUang = [];

  Future<void> loadData() async {
    final String response =
      await rootBundle.loadString('assets/data/uang.json');
    final data = await json.decode(response);
    setState(() {
      _dataUang = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dataUang.isEmpty) {
      return Center(child: Text('Loading...'),);
    }
    List<Widget> items = [];
    items.add(Center(
      child: Image(image: AssetImage('assets/images/dompet.png')),
    ));
    for (var i = 0; i < uang.length; i++) {
      var templateUang = _dataUang[uang[i].id];
      var img = templateUang['tipe'] == 'Koin'
      ? '${uang[i].id}.png'
      : '${uang[i].id}.jpg';
      items.add(
        Center(
          child: Image(
            image: AssetImage('assets/images/uang/uang-$img'),
            height: 128,
          ),
        )
      );
    }
    return Stack(
      children: items,
    );
  }
}

class Uang {
  int id;
  XY pos;
  Uang(this.id, this.pos);
}

class XY {
  double x;
  double y;
  XY(this.x, this.y);
}