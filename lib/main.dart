import 'dart:io';

import 'package:paguru_challenge_dart/controllers/bd_controller.dart';
import 'package:paguru_challenge_dart/controllers/equipament_controller.dart';

void main(List<String> args) {
  initBD();
}

void initBD() async{
  var bd_controller = BDController();
  try {
    await bd_controller.initBD();
    init();
  } catch (e) {
    print(e);
  }
}

void init() async{
  var equipament_controller = EquipamentController();
  print('\nCHOOSE A OPTION');
  print('1 - List equipaments');
  print('2 - Create new equipament');
  print('3 - Edit equipament');
  print('4 - Delete equipament');
  print('5 - Close program\n');
  loop:
  while (true) {
    print('Enter option');
    var option = int.tryParse(stdin.readLineSync()) ?? 0;
    switch (option) {
      case 1:
        await equipament_controller.show();
        break;
      case 2:
        await equipament_controller.create();
        print('Equipamet created!');
        break;
      case 3:
        await equipament_controller.edit();
        break;
      case 4:
        await equipament_controller.delete();
        break;
      case 5:
        print('=== Finished program ===');
        break loop;
      default:
        print('=== invalid option ===');
        break;
    }
  }
}
