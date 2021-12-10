import "dart:io" as io;
import 'package:flutter/material.dart';
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SqlModel {
  static final SqlModel _instance = new SqlModel.internal();
  factory SqlModel() => _instance;
  static late Database _db;

// TABLE NAMES
  static final tableAlarms = 'alarms';
  // static final tableWorldTime = 'worldTime';
  static final tablePickedTimeForStopwatch = 'pickedTimeForStopwatch';
  static final tableWorldclockCityList = 'tableWorldclockCityList';

  /// Initialize DB
  Future initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "myDatabase2.db");
    var taskDb = await openDatabase(path, version: 1);

    _db = taskDb;

    return taskDb;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  SqlModel.internal();

  Future creatingTables() async {
    try {
      var dbClient = await SqlModel().db;

      dbClient.execute("""
     CREATE TABLE IF NOT EXISTS $tableAlarms(
        auto_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        time1 TEXT,
        ringtone TEXT,
        repeat TEXT,
        vibrate TEXT,
        delete1 TEXT,
        isEnable TEXT,
        label TEXT)
      """);

      //   dbClient.execute("""
      //  CREATE TABLE IF NOT EXISTS $tableWorldTime(
      //     auto_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      //     cityName TEXT)
      //   """);

      dbClient.execute("""
     CREATE TABLE IF NOT EXISTS $tablePickedTimeForStopwatch(
        auto_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        timee1 TEXT)
      """);

      dbClient.execute("""
     CREATE TABLE IF NOT EXISTS $tableWorldclockCityList(
        auto_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        selectedCityName TEXT,
        timeDifference TEXT)
      """);

      return "tables created";
    } catch (e) {
      debugPrint(e.toString());
      return "table already exists";
    }
  }
}
