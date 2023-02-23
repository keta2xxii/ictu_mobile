import '../app/app_controller.dart';
import '../utils/db_helper.dart';

abstract class BaseDBModel {
  String get tableName;

  String get createSql;

  Future<List<T>> getAll<T>({required Decoder decoder}) async {
    var listMap = await DbHelper.db.query(tableName);
    return listMap.map((jsonRaw) => decoder(jsonRaw) as T).toList();
  }
}
