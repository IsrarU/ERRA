import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final databasename = "mydata.db";
  static final tablename = "mytable";
  static final version = 1;

  static final id = 'id';
  static final name = 'name';
  static final number = 'number';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    else{
      _database = await initDatabase();
      return _database;
    }
  }

  Future initDatabase()async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,databasename);
    return await openDatabase(path, version:1, onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version)async{
    await db.execute(
        '''
      create table $tablename(
      $id integer primary key,
      $name text not null,
      $number integer not null
      
      )
      '''
    );
  }

  Future<int?> insert(Map<String,dynamic> row)async{
    Database? db = await instance.database;
    return  await db?.insert(tablename, row);
  }

  static Future<List<Map<String,dynamic>>?> read()async{
    Database? db = await instance.database;
    return await db?.query(tablename);
  }

  Future<List<Map<String,dynamic>>?> specific(int age)async{
    Database? db = await instance.database;
    return await db?.query(tablename,where: "number>?",whereArgs: [number]);
  }
  Future<int?> deletedata(int id)async{
    Database? db = await instance.database;
    return await db?.delete(tablename,where: "id =?",whereArgs: [id]);
  }
  Future<int?> update(int id,Map<String,dynamic> row)async{
    Database? db = await instance.database;
    return await db?.update(tablename,row ,where: "id=?",whereArgs: [id]);
  }
}