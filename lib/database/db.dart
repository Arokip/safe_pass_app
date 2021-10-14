import 'dart:async';

import 'package:path/path.dart';
import 'package:safe_pass_app/data/password_item.dart';
import 'package:safe_pass_app/services/secure_storage.dart';
import 'package:sqflite/sqflite.dart';

class PasswordDatabase {
  final String passwordTable = 'password_table';

  static final PasswordDatabase instance = PasswordDatabase._init();

  static Database? _database;

  final SecureStorage secureStorage = SecureStorage();

  PasswordDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('password.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $passwordTable (id TEXT PRIMARY KEY, serviceName TEXT, userName TEXT)');
  }

  Future<void> insert(PasswordItem password) async {
    final db = await instance.database;
    db.insert(
      passwordTable,
      password.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    secureStorage.writeSecureData(password.id!, password.password);
  }

  Future<List<PasswordItem>> readAllPasswords() async {
    final db = await instance.database;
    final passwords = await db.query(passwordTable);

    List<PasswordItem> resultList = [];
    for (Map<String, Object?> dbMap in passwords) {
      final passwordId = PasswordItem.getPasswordId(dbMap);
      String password = await secureStorage.readPassword(passwordId);
      resultList.add(PasswordItem.fromMap(dbMap, password));
    }
    return resultList;
  }

  Future delete(String? id) async {
    if (id == null) return;
    final db = await instance.database;

    await db.delete(
      passwordTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    secureStorage.deleteSecureData(id);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
