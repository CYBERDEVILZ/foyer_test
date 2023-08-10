import 'package:foyer_test/model/location_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDB {
  static final SqliteDB _instance = SqliteDB._internal();

  factory SqliteDB() {
    return _instance;
  }

  SqliteDB._internal();

  /// get Database instance
  Future<Database> getDB() async {
    final db = openDatabase(
      join(await getDatabasesPath(), "location.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE locationInfo(id INTEGER PRIMARY KEY, lat TEXT, long TEXT, profile TEXT)",
        );
      },
      version: 1,
    );
    return db;
  }

  /// save to Database
  Future<void> insertLocationData(InfoModel model) async {
    final db = await getDB();
    print(model.toMap());
    await db.insert(
      "locationInfo",
      model.toMap(),
    );
  }

  /// retrieve all values
  Future<List<Map<String, dynamic>>> retrieveAllValues() async {
    final db = await getDB();
    return await db.query("locationInfo");
  }

  /// retrieve value based on current profile id
  Future<List<Map<String, dynamic>>> retrieveValueBasedOnId(int id) async {
    final db = await getDB();
    return await db.rawQuery('SELECT * FROM locationInfo where id=$id');
  }

  /// retrieve values based on lat and long
  Future<List<Map<String, dynamic>>> valuesBasedOnLatAndLong(
      double lat, double long) async {
    final db = await getDB();
    return await db
        .rawQuery("SELECT * from locationInfo where lat=$lat and long=$long");
  }

  /// retrieve values based on lat
  Future<List<Map<String, dynamic>>> valuesBasedOnLat(double lat) async {
    final db = await getDB();
    return await db.rawQuery("SELECT * from locationInfo where lat=$lat");
  }

  /// retrieve values based on long
  Future<List<Map<String, dynamic>>> valuesBasedOnLong(double long) async {
    final db = await getDB();
    return await db.rawQuery("SELECT * from locationInfo where long=$long");
  }
}
