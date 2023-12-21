import 'package:sqflite/sqflite.dart';

late Database database;
List<Map> memories = [];

void createDatabase() async {
  database = await openDatabase("memories.db", version: 1,
      onCreate: (database, version) {
        print("database created!");
        database
            .execute(
            "CREATE TABLE memory (id INTEGER PRIMARY KEY,title TEXT,description TEXT,img TEXT,date TEXT,time TEXT,status TEXT)")
            .then((value) {
          print("table created!");
        }).catchError((error) {
          print("Error when creating table ${error.toString()}");
        });
      }, onOpen: (database) {
        print("database Opened!");
        getDataFromDatabase(database).then((value) {
          memories = value;
        });
      });
}

Future<void> insertToDatabase({
  required String title,
  required String desc,
  required String img,
  required String date,
  required String time,
}) async {
  try {
    await database.transaction((txn) async {
      int insertedId = await txn.rawInsert(
          "INSERT INTO memory(title, description, img, date, time, status) VALUES(?, ?, ?, ?, ?, ?)",
          [title, desc, img, date, time, 'fav']);

      print("$insertedId inserted successfully!");
    });
  } catch (error) {
    print("Error when inserting new record: $error");
  }
}

Future<List<Map>> getDataFromDatabase(db) async{
   return await db.rawQuery("SELECT * FROM memory");
}