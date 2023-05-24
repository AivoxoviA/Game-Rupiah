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

  bool loadedUangMap = false;
  bool loadedDompet = false;
  Dompet dompet = Dompet([]);
  List _dataUang = [];
  List<int> uangIds = [];

  AssetImage bg = AssetImage('assets/images/dompet.png');
  var bgH = 128.0;

  Future<void> loadData() async {
    final String response = await rootBundle.loadString(
      'assets/data/uang.json'
    );
    final data = await json.decode(response);
    setState(() {
      _dataUang = data;
      loadedUangMap = true;
    });
    widget.dompet.read().then((value) {
      setState(() {
        dompet = value;
        loadedDompet = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loadedUangMap && !loadedDompet) {
      return Center(child: Text('Loading...'),);
    }
    List<Widget> items = [];
    for (var i = 0; i < dompet.uang.length; i++) {
      if (!uangIds.contains(i)) {
        uangIds.add(i);
      }
      var templateUang = _dataUang[dompet.uang[i].id];
      var img = templateUang['tipe'] == 'Koin'
      ? '${dompet.uang[i].id}.png'
      : '${dompet.uang[i].id}.jpg';
      var image = AssetImage('assets/images/uang/uang-$img');
      var imgH = 64.0;
      var wImage = Image(
        image: image,
        height: imgH,
      );
      if (dompet.uang[i].pos.x == 0 && dompet.uang[i].pos.y == 0) {
        dompet.uang[i].pos.x = MediaQuery.of(context).size.width/2 - imgH/2;
        dompet.uang[i].pos.y = MediaQuery.of(context).size.height/2 - imgH - bgH;
      }
      items.add(Positioned(
        left: dompet.uang[i].pos.x,
        top: dompet.uang[i].pos.y,
        child: Draggable(
          feedback: Container(),
          child: wImage,
          onDragStarted: () {
            setState(() {
              uangIds.remove(i);
              uangIds = [...uangIds, i];
              l.d(i, uangIds);
            });
          },
          onDragUpdate: (details) {
            setState(() {
              dompet.uang[uangIds.last].pos.x =  details.globalPosition.dx - (imgH / 2);
              dompet.uang[uangIds.last].pos.y =  details.globalPosition.dy - (imgH / 2);
            });
          },
          onDragEnd: (details) {
            setState(() {
              dompet.write();
            });
          },
        ),
      ));
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Image(image: bg, height: bgH,),
        ),
        ...uangIds.map((id) => items[id]).toList()
      ],
    );
  }
}