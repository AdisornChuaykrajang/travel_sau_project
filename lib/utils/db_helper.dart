// ignore_for_file: unused_local_variable, prefer_is_empty

import 'package:sqflite/sqflite.dart';
import 'package:travel_sau_project/models/travel.dart';
import 'package:travel_sau_project/models/user.dart';
import 'package:travel_sau_project/views/register_ui.dart';

class DBHelper {
  static Future<Database> db() async {
    return openDatabase('travelrecord.db', version: 1,
        onCreate: (Database database, int version) async {
      await createUserTable(database);
      await createTravelTable(database);
    });
  }

//method create User table
  static Future<void> createUserTable(Database database) async {
    await database.execute('''
    create table IF NOT EXISTS usertb(
      id integer primary key autoincrement not null ,
      fullname text ,
      email text ,
      phone text ,
      username text ,
      password text ,
      picture text 
    )
    ''');
  }

//method create Travel table
  static Future<void> createTravelTable(Database database) async {
    await database.execute('''
    create table IF NOT EXISTS usertb(
      id integer primary key autoincrement not null ,
      pictureTravel text ,
      placeTravel text ,
      costTravel text ,
      dateTravel text ,
      dayTravel text ,
      locationTravel text 
    )
    ''');
  }

  static Future<int> insertUser(User user) async {
    final db = await DBHelper.db();

    final id = await db.insert(
      'usertb', //ชื่อดารางที่สร้างไว้
      user.toMap(), //น่าข้อมูลใส่ลงในตารางให้ตรงกับคอลัมภ์ในตาราง
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<int> insertTravel(Travel travel) async {
    final db = await DBHelper.db();

    final id = await db.insert(
      'usertb', //ชื่อดารางที่สร้างไว้
      travel.toMap(), //น่าข้อมูลใส่ลงในตารางให้ตรงกับคอลัมภ์ในตาราง
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
}
