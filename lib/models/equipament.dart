import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class Equipament {
  String id;
  String name;
  String model;
  String company;
  double price;
  DateTime created_at;
  DateTime updated_at;

  Equipament(
      {
      @required this.name,
      @required this.model,
      @required this.company,
      @required this.price,
      }) {
    id = Uuid().v1();
    created_at = DateTime.now();
    updated_at = DateTime.now();
  }

  Equipament.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    company = json['company'];
    price = json['price'];
    created_at = DateTime.parse(json['created_at']);
    updated_at = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['model'] = model;
    data['company'] = company;
    data['price'] = price;
    data['created_at'] = created_at.toString();
    data['updated_at'] = updated_at.toString();
    return data;
  }
}
