// ignore_for_file: prefer_is_empty, avoid_returning_null_for_void, null_check_always_fails


import 'package:sqflite/sqflite.dart';
import 'package:travel_sau_project/models/travel.dart';
import 'package:travel_sau_project/models/user.dart';

class DBHelper {
  static Future<Database> db() async {
    return openDatabase('travelrecord.db', version: 1,
        onCreate: (Database database, int version) async {
      //สร้างตาราง
      await createUserTable(database);
      await createTravelTable(database);
    });
  }

  static Future<void> createUserTable(Database database) async {
    await database.execute('''
  create table usertb(
    id integer primary key autoincrement not null,
    fullname text,
    email text,
    phone text,
    username text,
    password text,
    picture text
  )
''');
  }

  static Future<void> createTravelTable(Database database) async {
    await database.execute('''
  create table traveltb(
    id integer primary key autoincrement not null,
    pictureTravel text,
    placeTravel text,
    costTravel text,
    dateTravel text,
    dayTravel text,
    locationTravel text
  )
''');
  }

//บันทึกข้อมูล User
  static Future<int> insertUser(User user) async {
    final db = await DBHelper.db();

    final id = await db.insert(
      'usertb',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> insertTravel(Travel travel) async {
    final db = await DBHelper.db();

    final id = await db.insert(
      'traveltb',
      travel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<User?> checkSignin(String username, String password) async {
    final db = await DBHelper.db();

    List<Map<String, dynamic>> result = await db.query(
      'usertb',
      where: 'username = ? and password = ?',
      whereArgs: [username, password],
    );
    if (result.length > 0) {
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }

  //ดึงข้อมูลทั้งหมดจาก travel
  static Future<List<Travel>> getAllTravel() async {
    //ติดต่อ DB
    final db = await DBHelper.db();

    //ดึงข้อมูลเก็บในตัวแปร
    final result = await db.query(
      'traveltb',
      orderBy: 'id DESC',
    );

    return result.map((data) => Travel.fromMap(data)).toList();
  }
}