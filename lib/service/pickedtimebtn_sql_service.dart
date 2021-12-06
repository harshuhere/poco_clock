import 'package:clock_poco/service/sql_service.dart';

class SqlTimebtnService {
  Future<bool> insertNewTimebtn(Map<String, Object> data, table) async {
    final dbClient = await SqlModel().db;
    // var user = await SaveData().getUserData();

    var isExist = await _checkrecordExists(data['timee1'].toString());

    if (!isExist) {
      try {
        var result = await dbClient.insert(table, data);
        print("result $result");
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      throw "already exists";
    }
  }

  Future<bool> _checkrecordExists(String data) async {
    final dbClient = await SqlModel().db;
    // var user = await SaveData().getUserData();

    try {
      var result = await dbClient.rawQuery(
          "select *from  ${SqlModel.tablePickedTimeForStopwatch} where timee1=$data");

      print("result $result");

      if (result.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Map<String, Object?>>> getAllTableData(String table) async {
    final dbClient = await SqlModel().db;
    // var user = await SaveData().getUserData();

    try {
      var result = await dbClient.rawQuery("select *from $table");

      print("result $result");

      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
