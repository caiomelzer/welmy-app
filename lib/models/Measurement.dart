import 'dart:ffi';

class Measurement {
  int id;
  String fullname;
  double weight;
  String computedAt;

  Measurement(this.id,this.fullname, this.weight, this.computedAt);

  factory Measurement.fromJson(Map<String, dynamic> json){
    return Measurement(
      json['id'] as int,
      json['fullname'] as String,
      json['weight'] as double,
      json['computedAt'] as String,
    );
  }
}