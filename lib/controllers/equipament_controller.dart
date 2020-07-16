import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:paguru_challenge_dart/controllers/bd_controller.dart';
import 'package:paguru_challenge_dart/models/equipament.dart';

class EquipamentController {
  var bd_controller = BDController();
  String formatMoney(dynamic value) {
    return NumberFormat.simpleCurrency(
            locale: 'pt_BR', name: 'R\$ ', decimalDigits: 2)
        .format(value);
  }

  Future show() {
    return Future.sync(() async {
      List listEquipaments = await bd_controller.getEquipaments();
      if (listEquipaments.isNotEmpty) {
        listEquipaments.asMap().forEach((i, element) {
          var equipament = Equipament.fromJson(element);
          print('=== ${equipament.name} ===');
          print('Id: ${i + 1}');
          print('Model: ${equipament.model}');
          print('Company: ${equipament.company}');
          print('Price: ${formatMoney(equipament.price)}');
        });
      } else {
        print('Not found equipaments');
      }
      print('\n');
    });
  }

  Future create() async {
    print('Enter the equipament name');
    var name = stdin.readLineSync();
    print('Enter the equipament model');
    var model = stdin.readLineSync();
    print('Enter the equipament company');
    var company = stdin.readLineSync();
    print('Enter the equipament price');
    var price;
    while (true) {
      price = double.tryParse(stdin.readLineSync()) ?? 0;
      if (price == 0) {
        print('Invalid value');
      } else {
        break;
      }
    }

    var equipament =
        Equipament(name: name, model: model, company: company, price: price);
    var listEquipaments = await bd_controller.getEquipaments();
    listEquipaments.add(equipament.toJson());
    return Future.sync(() async => await File(BDController.bd_path)
        .writeAsString(json.encode(listEquipaments)));
  }

  Future edit() async {
    return Future.sync(() async {
      List listEquipaments = await bd_controller.getEquipaments();
      if (listEquipaments.isNotEmpty) {
        print('Equipaments');
        listEquipaments.asMap().forEach((i, element) {
          var equipament = Equipament.fromJson(element);
          print('${i + 1} - ${equipament.name}');
        });
        print('Choose equipament');
        var id;
        while (true) {
          id = int.tryParse(stdin.readLineSync()) ?? 0;
          if (id == 0 || id > listEquipaments.length) {
            print('Invalid value');
          } else {
            break;
          }
        }
        if (await editEquipament(id, listEquipaments)) {
          print('Equipament updated');
        } else {
          print('Failed to edit equipament');
        }
      } else {
        print('Option unavailable, no equipaments');
      }
    });
  }

  Future editEquipament(id, equipaments) {
    return Future.sync(() async {
      var equipament = equipaments[id - 1];
      print('Which attribute you want to edit?');
      print('1 - Name');
      print('2 - Model');
      print('3 - Company');
      print('4 - Price');
      print('5 - All');
      var option;
      while (true) {
        option = double.tryParse(stdin.readLineSync()) ?? 0;
        if (option == 0) {
          print('Invalid value');
        } else {
          break;
        }
      }

      switch (option) {
        case 1:
          print('Enter the name');
          equipament['name'] = stdin.readLineSync();
          break;
        case 2:
          print('Enter the model');
          equipament['model'] = stdin.readLineSync();
          break;
        case 3:
          print('Enter the company');
          equipament['company'] = stdin.readLineSync();
          break;
        case 4:
          print('Enter the price');
          var price;
          while (true) {
            price = double.tryParse(stdin.readLineSync()) ?? 0;
            if (price == 0) {
              print('Invalid value');
            } else {
              equipament['price'] = price;
              break;
            }
          }
          break;
        default:
          print('Enter the name');
          equipament['name'] = stdin.readLineSync();
          print('Enter the model');
          equipament['model'] = stdin.readLineSync();
          print('Enter the company');
          equipament['company'] = stdin.readLineSync();
          print('Enter the price');
          var price;
          while (true) {
            price = double.tryParse(stdin.readLineSync()) ?? 0;
            if (price == 0) {
              print('Invalid value');
            } else {
              equipament['price'] = price;
              break;
            }
          }
          break;
      }
      equipament['updated_at'] = DateTime.now().toString();
      equipaments[id - 1] = equipament;
      var response = await File(BDController.bd_path)
          .writeAsString(json.encode(equipaments));
      return response != null;
    });
  }

  Future delete() {
    return Future.sync(() async {
      List listEquipaments = await bd_controller.getEquipaments();
      if (listEquipaments.isNotEmpty) {
        print('Equipaments');
        listEquipaments.asMap().forEach((i, element) {
          var equipament = Equipament.fromJson(element);
          print('${i + 1} - ${equipament.name}');
        });
        print('Choose equipament');
        var id;
        while (true) {
          id = int.tryParse(stdin.readLineSync()) ?? 0;
          if (id == 0 || id > listEquipaments.length) {
            print('Invalid value');
          } else {
            break;
          }
        }
        listEquipaments.removeAt(id-1);
        var response = await File(BDController.bd_path)
            .writeAsString(json.encode(listEquipaments));
        if (response != null) {
          print('Equipament deleted');
        } else {
          print('Failed to deleted equipament');
        }
      } else {
        print('Option unavailable, no equipaments');
      }
    });
  }
}
