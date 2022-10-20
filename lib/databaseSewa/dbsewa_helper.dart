//dbsewa_helper ini dibuat untuk membuat database, membuat tabel, proses insert, read, update dan delete pada data Sewa PS

import 'package:uts_crud_113/model/sewaps.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbSewa {
  static final DbSewa _instance = DbSewa._internal();
  static Database? _database;

  // Untuk menginisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableSewa';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnNoHP = 'noHP';
  final String columnEmail = 'email';
  final String columnJenisPS = 'jenisPS';

  DbSewa._internal();
  factory DbSewa() => _instance;

  // Untuk mengecek apakah database ada atau tidak
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
    await deleteDatabase(path);

    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  // Untuk membuat tabel beserta field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNama TEXT,"
        "$columnNoHP TEXT,"
        "$columnEmail TEXT,"
        "$columnJenisPS TEXT)";
    await db.execute(sql);
  }

  // Membuat fungsi tambah ke database
  Future<int?> saveSewa(SewaPS sewa) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, sewa.toMap());
  }

  // Mmebuat fungsi read  pada database
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnNama,
      columnJenisPS,
      columnNoHP,
      columnEmail
    ]);

    return result.toList();
  }

  // Membuat fungsi untuk update pada database
  Future<int?> updateSewa(SewaPS sewa) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, sewa.toMap(),
        where: '$columnId = ?', whereArgs: [sewa.id]);
  }

  // Membuat fungsi untuk hapus pada database
  Future<int?> deleteSewa(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
