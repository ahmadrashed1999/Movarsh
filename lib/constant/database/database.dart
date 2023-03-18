import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sql {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDataBase();
      return _db;
    }
    return _db!;
  }

  intialDataBase() async {
    String path = await getDatabasesPath();
    // String path2 = join(path,'test.db'); or
    String path2 = path + '/model.db';
    Database db = await openDatabase(path2,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute(
        '''CREATE TABLE Models (id  INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
        title TEXT NOT NULL,
        adult bool NOT NULL,
        backdropPath TEXT NOT NULL,
        genres LIST NOT NULL,
        idmov INTEGER NOT NULL,
        overview TEXT NOT NULL,
        posterPath TEXT NOT NULL,
        releaseDate TEXT NOT NULL,
        tagline TEXT NOT NULL,
        title TEXT NOT NULL,
        voteAverage REAL NOT NULL)''');

    batch.commit();
    print('craete');
  }

  readData(sql) async {
    Database? Mydb = await db;
    List<Map> response = await Mydb!.rawQuery(sql);
    return response;
  }

  insertData(sql) async {
    Database? Mydb = await db;
    int response = await Mydb!.rawInsert(sql);
    print('inserted');
    return response;
  }

  updateData(sql) async {
    Database? Mydb = await db;
    int response = await Mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(sql) async {
    Database? Mydb = await db;
    int response = await Mydb!.rawDelete(sql);
    return response;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade =====================================");
  }

  deleteMyDataBase() async {
    String path = await getDatabasesPath();
    // String path2 = join(path,'test.db'); or
    String path2 = path + '/model.db';
    return await deleteDatabase(path2);
  }
}
