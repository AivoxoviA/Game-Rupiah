import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_rupiah/dompet/tukar.dart';
import 'package:game_rupiah/main.dart';
import 'package:game_rupiah/models/dompet.dart';

class DompetApp extends StatefulWidget {
  final Dompet dompet;

  const DompetApp({super.key, required this.dompet});
  @override
  State<DompetApp> createState() => DompetAppState();
}

class DompetAppState extends State<DompetApp> {
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

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  List<KoinSize> sizes = [
    KoinSize(50, 44.0),
    KoinSize(100, 56.0),
    KoinSize(200, 56.0),
    KoinSize(500, 60.0),
    KoinSize(1000, 64.0),
    KoinSize(2000, 64.0),
    KoinSize(5000, 64.0),
    KoinSize(10000, 64.0),
    KoinSize(20000, 64.0),
    KoinSize(50000, 64.0),
    KoinSize(100000, 64.0),
  ];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
      var imgH = sizes.singleWhere((element) {
        return element.nominal == templateUang['nominal'];
      }).size;
      var wImage = Image(
        image: image,
        height: imgH,
      );
      if (dompet.uang[i].pos.x == 0 && dompet.uang[i].pos.y == 0) {
        dompet.uang[i].pos.x = screenWidth/2 - imgH/2;
        dompet.uang[i].pos.y = screenHeight/2 - imgH - bgH;
      }

      checkExchange(dompet.uang[i]);

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
    List<OutlinedButton> exchangeTo =  [];
    if (uangToBeExchanged.isNotEmpty) {
      exchangeTo = Tukar(_dataUang, uangToBeExchanged, sizes, this).process();
    }

    var bgImg = Image(image: bg, width: screenWidth,);
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: screenWidth/2 - bgImg.width!/2,
          top: screenHeight/2,
          child: bgImg,
        ),
        ...uangIds.map((id) => items[id]).toList(),
        Positioned(
          top: screenHeight/3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 1.0,
              width: screenWidth,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: screenHeight/3 - 6,
          child: Container(
            color: Colors.white,
            child: Text('Tukar'),
          ),
        ),
        Positioned(
          top: 8,
          child: SizedBox(
            width: screenWidth,
            height: 72.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: exchangeTo,
            ),
          )
        ),
      ],
    );
  }
  
  List<Uang> uangToBeExchanged = [];

  void exchangeTo(item, ids) {
    l.d('tukar uang!!!');
    l.d(ids);
    l.d(uangToBeExchanged);
    for (var i = 0; i < uangToBeExchanged.length; i++) {
      var uang = uangToBeExchanged[i];
      dompet.uang.remove(uang);
    }
    for (var i = 0; i < ids.length; i++) {
      uangToBeExchanged.removeAt(ids[i]);
    }
    var imgH = sizes.singleWhere((element) {
      return element.nominal == item['nominal'];
    }).size;
    var x = screenWidth/2 - imgH/2;
    var y = screenHeight/2 - imgH - bgH;
    dompet.uang.add(Uang(item['id'], Pos(x, y)));
    setState(() {
      uangIds = [];
      dompet.write();
    });
  }

  void checkExchange(Uang uang) {
    if (
      uang.pos.y
      <
      screenHeight/3 - sizes.singleWhere((element) {
        return element.nominal ==_dataUang[uang.id]['nominal'];
      }).size 
    ) {
      var index = uangToBeExchanged.indexOf(uang);
      if (index == -1) {
        uangToBeExchanged.add(uang);
      }
    } else {
      uangToBeExchanged.remove(uang);
    }
  }
}

class KoinSize {
  num nominal;
  double size;
  KoinSize(this.nominal, this.size);
}