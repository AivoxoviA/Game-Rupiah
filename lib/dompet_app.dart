import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_rupiah/main.dart';
import 'package:game_rupiah/models/dompet.dart';

class DompetApp extends StatefulWidget {
  final Dompet dompet;

  const DompetApp({super.key, required this.dompet});
  @override
  State<DompetApp> createState() => _DompetAppState();
}

class _DompetAppState extends State<DompetApp> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Dompet dompet = Dompet([]);
  List _dataUang = [];

  AssetImage bg = AssetImage('assets/images/dompet.png');
  Future<void> loadData() async {
    final String response =
      await rootBundle.loadString('assets/data/uang.json');
    final data = await json.decode(response);
    setState(() {
      _dataUang = data;
      widget.dompet.read().then((value) {
        dompet = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dataUang.isEmpty) {
      return Center(child: Text('Loading...'),);
    }
    List<Widget> items = [];
    items.add(Center(
      child: Image(image: bg),
    ));
    List uang = dompet.uang;
    dompet.write();
    for (var i = 0; i < uang.length; i++) {
      var templateUang = _dataUang[uang[i].id];
      var img = templateUang['tipe'] == 'Koin'
      ? '${uang[i].id}.png'
      : '${uang[i].id}.jpg';
      var image = AssetImage('assets/images/uang/uang-$img');
      var wImage = Image(
        image: image,
        height: 64,
      );
      items.add(Positioned(
        left: uang[i].pos.x,
        top: uang[i].pos.y,
        child: Draggable(
          feedback: Container(),
          child: wImage,
          onDragUpdate: (details) {
            setState(() {
              uang[i].pos.x =  details.globalPosition.dx - 32;
              uang[i].pos.y =  details.globalPosition.dy - 32;
            });
          },
          onDragEnd: (details) {
            l.d('drag end!');
            setState(() {
              dompet.write();
            });
          },
        ),
      ));
    }
    return Stack(
      alignment: Alignment.center,
      children: items,
    );
  }
}