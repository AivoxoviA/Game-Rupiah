// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dompet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dompet _$DompetFromJson(Map<String, dynamic> json) => Dompet(
      (json['uang'] as List<dynamic>)
          .map((e) => Uang.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DompetToJson(Dompet instance) => <String, dynamic>{
      'uang': instance.uang.map((e) => e.toJson()).toList(),
    };

Uang _$UangFromJson(Map<String, dynamic> json) => Uang(
      json['id'] as int,
      Pos.fromJson(json['pos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UangToJson(Uang instance) => <String, dynamic>{
      'id': instance.id,
      'pos': instance.pos.toJson(),
    };

Pos _$PosFromJson(Map<String, dynamic> json) => Pos(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$PosToJson(Pos instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

// **************************************************************************
// JsonLiteralGenerator
// **************************************************************************

final _$dompetJsonLiteral = {
  'uang': [
    {
      'id': 0,
      'pos': {'x': 0, 'y': 0}
    }
  ]
};
