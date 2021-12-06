import 'package:clock_poco/service/sql_service.dart';

class SqlAlarmService {
  Future<bool> insertNewAlarm(dynamic data, table) async {
    final dbClient = await SqlModel().db;
    // var user = await SaveData().getUserData();

    try {
      var result = await dbClient.insert(table, data);

      print("result $result");

      return true;
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
