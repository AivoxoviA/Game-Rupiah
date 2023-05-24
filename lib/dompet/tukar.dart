import 'package:flutter/material.dart';
import 'package:game_rupiah/dompet_app.dart';
import 'package:game_rupiah/models/dompet.dart';

class Tukar{
  List mapUang;
  List<Uang> receh;
  List<KoinSize> sizes;
  DompetAppState state;
  num total = 0;
  List<int> ids = [];

  Tukar(this.mapUang, this.receh, this.sizes, this.state) {
    for (var i = 0; i < receh.length; i++) {
      total += mapUang[receh[i].id]['nominal'];
      ids.add(i);
    }
  }

  List<OutlinedButton> process() {
    List penukar = [];
    for (var i = 0; i < mapUang.length; i++) {
      var uang = mapUang[i];
      uang['id'] = i;
      if (uang['tipe'] == 'Khusus') break;
      if (
        uang['nominal'] <= total
      ) {
        penukar.add(uang);
      }
    }
    List<OutlinedButton> changes = [];
    for (var i = penukar.length - 1; i >= 0; i--) {
      var item = penukar[i];
      var imgFile = item['tipe'] == 'Koin'
        ? "${item['id']}.png" : "${item['id']}.jpg";
      Image img = Image(
        height: sizes.singleWhere((element) {
          return element.nominal == item['nominal'];
        }).size,
        image: AssetImage('assets/images/uang/uang-$imgFile')
      );
      OutlinedButton changeTo = OutlinedButton(
        onPressed: () {
          state.exchangeTo(item, ids.reversed.toList());
        },
        child: img
      );
      changes.add(changeTo);
    }
    return changes;
  }
}