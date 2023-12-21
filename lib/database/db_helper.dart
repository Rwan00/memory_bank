import 'package:sqflite/sqflite.dart';

late Database database;

void createDatabase() async {
  database = await openDatabase("memories.db", version: 1,
      onCreate: (database, version) {
        print("database created!");
        database
            .execute(
            "CREATE TABLE memory (id INTEGER PRIMARY KEY,title TEXT,description TEXT,img TEXT,date TEXT,time TEXT,status TEXT)")
            .then((value) {
          print("tablr created!");
        }).catchError((error) {
          print("Error whem creating table ${error.toString()}");
        });
      }, onOpen: (database) {
        print("database Opened!");
      });
}

Future<void> insertToDatabase() async {
  try {
    await database.transaction((txn) async {
      int insertedId = await txn.rawInsert(
          "INSERT INTO memory(title, description, img, date, time, status) VALUES(?, ?, ?, ?, ?, ?)",
          ['first', 'desc', 'kjk', '123', '22', 'fav']);

      print("$insertedId inserted successfully!");
    });
  } catch (error) {
    print("Error when inserting new record: $error");
  }
}