import 'package:memory_bank/cubit/app_cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../views/archived_screen.dart';
import '../../views/favourites_screen.dart';
import '../../views/memories_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  final List pages = [
    {'page': const MemoriesScreen(), 'title': "Your Memories"},
    {
      'page': const FavouritesScreen(),
      'title': "Favourite Memories",
    },
    {
      'page': const ArchivedScreen(),
      'title': "Archived Memories",
    },
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }

 late Database database;
  List<Map> memories = [];
  List<Map> favMemories = [];
  List<Map> archivedMemories = [];

  void createDatabase() {
    openDatabase("memories.db", version: 1, onCreate: (database, version) {
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
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
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
            [title, desc, img, date, time, 'none']);

        print("$insertedId inserted successfully!");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      });
    } catch (error) {
      print("Error when inserting new record: $error");
    }
  }

   getDataFromDatabase(db)  {

      memories = [];
      favMemories = [];
      archivedMemories = [];

    emit(AppGetDatabaseLoadingState());
     db.rawQuery("SELECT * FROM memory").then((value) {

      print(memories);
      value.forEach((element){
        if(element["status"] == "none"){
          memories.add(element);
        }else if(element["status"] == "fav"){
          favMemories.add(element);
        }else{
          archivedMemories.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

void updateData({
    required String status,
    required int id,
})async{
   database.rawUpdate(
      "UPDATE memory SET status = ? WHERE id = ?",
      [status,id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
   });
}

void deleteData({
    required int id,
})async{
   database.rawDelete(
      "DELETE FROM memory WHERE id = ?",
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
   });
}

bool isLike = false;

  changeLikeState(){
    isLike = !isLike;
    emit(AppChangeLikeState());
  }
  bool isArchived = false;

  changeArchivedState(){
    isArchived = !isArchived;
    emit(AppChangeArchivedState());
  }

  
}
