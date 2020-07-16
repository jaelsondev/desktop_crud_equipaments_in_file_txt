import 'dart:convert';
import 'dart:io';

class BDController {
  String directory_path = '${Directory.current.parent.path}/bd';
  static String bd_path = '${Directory.current.parent.path}/bd/data.txt';
  Future initBD() async {
    try {
      await createDirectory();
      await createFile();
    } catch (e) {
      print('Failed to created data controller');
    }
  }

  Future createDirectory() async {
    var uri = Uri.directory(directory_path);
    var directoryExists = await Directory(directory_path).exists();
    if (!directoryExists) {
      try {
        return await Directory.fromUri(uri).create();
      } catch (e) {
        print('failed to create directory: $e');
      }
    }
  }

  Future createFile() async {
    var uri = Uri.file(bd_path);
    var bdExists = await File(bd_path).exists();
    if (!bdExists) {
      try {
        return await File.fromUri(uri).create();
      } catch (e) {
        print('failed to create database: $e');
      }
    }
  }

  Future getEquipaments() async{
    var database = await File(BDController.bd_path).readAsString();
    return database.isNotEmpty ? json.decode(database) : [];
  }
}
