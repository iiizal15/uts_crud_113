// ignore_for_file: non_constant_identifier_names

//dbsewa_helper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete

import 'package:uts_crud_113/model/sewaps.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbSewa {
  static final DbSewa _instance = DbSewa._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnMobileNo = 'mobileNo';
  final String columnEmail = 'email';
  final String columnCompany = 'company';

  DbSewa._internal();
  factory DbSewa() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'sewaps.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnMobileNo TEXT,"
        "$columnEmail TEXT,"
        "$columnCompany TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveSewa(SewaPS sewa) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, sewa.toMap());
  }

  //read database
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnCompany,
      columnMobileNo,
      columnEmail
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateSewa(SewaPS sewa) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, sewa.toMap(),
        where: '$columnId = ?', whereArgs: [sewa.id]);
  }

  //hapus database
  Future<int?> deleteSewa(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
