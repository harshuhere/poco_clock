import 'package:clock_poco/service/sql_service.dart';

class DeleteSelectedTime {
  Future<bool> deleteSelectedTime(dynamic data, table) async {
    final dbClient = await SqlModel().db;
    // var user = await SaveData().getUserData();

    try {
      var result = await dbClient
          .rawQuery("""DELETE FROM $table WHERE timee1 = '$data'""");

      print("result $result");

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
