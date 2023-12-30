import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:memory_bank/cubit/app_cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../views/archived_screen.dart';
import '../../views/favourites_screen.dart';
import '../../views/memories_screen.dart';
import '../../widgets/bottom_sheet_body.dart';

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
      getDataFromDatabase(database).then((value) {
        memories = value;
        print(memories);
        emit(AppGetDatabaseState());
      });
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
            [title, desc, img, date, time, 'fav']);

        print("$insertedId inserted successfully!");
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database).then((value) {
          memories = value;
          print(memories);
          emit(AppGetDatabaseState());
        });
      });
    } catch (error) {
      print("Error when inserting new record: $error");
    }
  }

  Future<List<Map>> getDataFromDatabase(db) async {
    return await db.rawQuery("SELECT * FROM memory");
  }



  
}
