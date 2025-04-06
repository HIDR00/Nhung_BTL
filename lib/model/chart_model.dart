// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChartModel {
  int temp;
  int hum;
  ChartModel({required this.hum,required this.temp});

  factory ChartModel.fromMap(Map<String, dynamic> map) {
    return ChartModel(
      temp: map['temp'] as int,
      hum: map['hum'] as int,
    );
  }


  factory ChartModel.fromJson(String source) => ChartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
