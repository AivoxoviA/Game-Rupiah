import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:game_rupiah/main.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';
part 'dompet.g.dart';

@JsonSerializable(explicitToJson: true)
class Dompet {
  Dompet(this.uang);

  List<Uang> uang;

  factory Dompet.fromJson(Map<String, dynamic> json) => _$DompetFromJson(json);

  Map<String, dynamic> toJson() => _$DompetToJson(this);

  static Future<Dompet> load() async{
    final String jsonString = await rootBundle.loadString(
      'assets/data/dompet.json'
    );
    final dompetJson = await json.decode(jsonString);
    l.d(dompetJson);
    return Dompet.fromJson(dompetJson);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/dompet.json');
  }

  Future<Dompet> read() async {
    final file = await _localFile;
    final exist = await file.exists();
    if (!exist) {
      await write();
    }
    final contents = await file.readAsString();
    final jsonDompet = await json.decode(contents);
    return Dompet.fromJson(jsonDompet);
  }

  Future<File> write() async {
    final file = await _localFile;
    String jsonString = jsonEncode(toJson());
    return file.writeAsString(jsonString);
  }

  void add(Uang uang) {
    this.uang.add(uang);
  }
}

@JsonSerializable(explicitToJson: true)
class Uang {
  Uang(this.id, this.pos);

  int id;
  Pos pos;

  factory Uang.fromJson(Map<String, dynamic> json) => _$UangFromJson(json);

  Map<String, dynamic> toJson() => _$UangToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Pos {
  double x;
  double y;

  Pos(this.x, this.y);

  factory Pos.fromJson(Map<String, dynamic> json) => _$PosFromJson(json);

  Map<String, dynamic> toJson() => _$PosToJson(this);
}

@JsonLiteral('../../assets/data/dompet.json')
Map get dompet => _$dompetJsonLiteral;