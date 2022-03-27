import 'dart:async';
import 'dart:io';
import 'model/tamu.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tamu.db';
    //create, read databases
    var tamuDatabase = openDatabase(path, version: 5, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return tamuDatabase;
  }

  //buat tabel baru dengan nama tamu
  void _createDb(Database db, int version) async {
    await db.execute(''
        'CREATE TABLE tamu (id INTEGER PRIMARY KEY AUTOINCREMENT,nama TEXT, alamat TEXT,instansi TEXT,email TEXT, telp TEXT, tujuan TEXT, keterangan TEXT, createDate TEXT, ttd TEXT, photo TEXT)'
        '');
  }
  
  //select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('tamu', orderBy: 'id desc');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> selectBulan() async {
    Database db = await this.initDb();
    var mapList = await db.query('tamu', where: 'bulan=?', whereArgs: [getBulan('bulan')]);
    return mapList;
  }

  //create databases
  Future<int> insert(Tamu object) async {
    Database db = await this.initDb();
    int count = await db.insert('tamu', object.toMap());
    return count;
  }

  //update databases
  // Future<int> update(Item object) async {
  //   Database db = await this.initDb();
  //   int count = await db
  //       .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
  //   return count;
  // }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('tamu', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Tamu>> getTamuList() async {
    var tamuMapList = await select();
    int count = tamuMapList.length;
    List<Tamu> tamuList = List<Tamu>();
    for (int i = 0; i < count; i++) {
      tamuList.add(Tamu.fromMap(tamuMapList[i]));
    }
    return tamuList;
  }
 Future<List<Tamu>> getBulan(String bulan) async {
    var tamuMapList = await select();
    int count = tamuMapList.length;
    List<Tamu> tamuList = List<Tamu>();
    for (int i = 0; i < count; i++) {
      tamuList.add(Tamu.fromMap(tamuMapList[i]));
    }
    return tamuList;
  }
  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
