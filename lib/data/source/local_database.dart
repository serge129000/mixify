import 'package:mixify/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  Future<Database> appDataBase() async => await openDatabase(
        databaseName,
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE downloads(id INTEGER PRIMARY KEY, title VARCHAR, cover VARCHAR)");
        },
      );
}
