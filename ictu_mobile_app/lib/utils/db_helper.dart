import 'package:flutter/widgets.dart';
import 'package:ictu_mobile_app/app/app_config.dart';
import 'package:ictu_mobile_app/models/db/product_tb.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static late Database _db;

  static final _initScript = [
    ProductTB().createSql,
  ];

  /// { version : script}
  static final _migrationScripts = {
    2: '''''',
  };

  static _onCreate(Database db, int version) async {
    try {
      for (var script in _initScript) {
        await db.execute(script);
      }
      debugPrint('DbHelper _onCreate SUCCESS: version $version');
    } on Exception catch (e) {
      debugPrint("DbHelper _onCreate ERROR: $e");
    }
  }

  static _onUpgrade(Database db, int oldVersion, int newVersion) {
    try {
      _migrationScripts.forEach((key, value) async {
        if (key <= newVersion) {
          await db.execute(value);
        }
      });
      debugPrint(
        'DbHelper _onUpgrade SUCCESS: version $oldVersion => $newVersion',
      );
    } on Exception catch (e) {
      debugPrint(
        "DbHelper _onUpgrade version $oldVersion => $newVersion ERROR: $e",
      );
    }
  }

  static Future init() async {
    _db = await openDatabase(
      AppConfig.databasePath,
      version: AppConfig.databaseVersion,
      singleInstance: true,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<bool> existsColumnInTable(
    Database db,
    String tableName,
    String columnName,
  ) async {
    try {
      var listMap = await db.rawQuery(
        "SELECT COUNT(*) AS count FROM pragma_table_info('$tableName') WHERE name='$columnName'",
      );
      return (listMap.first['count']! as int) > 0;
    } on Exception catch (e) {
      debugPrint("DbHelper - existsColumnInTable: $e");
      return false;
    }
  }

  static Database get db => _db;
}
