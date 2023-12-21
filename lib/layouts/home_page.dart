import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:memory_bank/views/archived_screen.dart';
import 'package:memory_bank/views/favourites_screen.dart';
import 'package:memory_bank/views/memories_screen.dart';
import 'package:sqflite/sqflite.dart';


import '../widgets/input_field.dart';
import '../widgets/upload_img.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List _pages = [
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

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String time = DateFormat('hh:mm a').format(DateTime.now()).toString();
 

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex]["title"],
          style: GoogleFonts.aDLaMDisplay(color: Colors.grey),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(249, 249, 224, 1),
      ),
      body: _pages[_selectedIndex]["page"],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            scaffoldKey.currentState!.showBottomSheet((context) => SingleChildScrollView(
              child: Container(
                color: const Color.fromRGBO(138, 205, 215,0.1),
                    width: double.infinity,
                    height: height * 0.65,
                    child: Column(
                      children: [
                        InputField(
                          title: 'Title',
                          hint: 'The title of your memory',
                          controller: titleController,
                        ),
                        InputField(
                          title: 'Description',
                          hint: 'Describe your memory',
                          controller: descController,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: InputField(
                                title: "Date",
                                hint: DateFormat.yMd().format(selectedDate),
                                widget: IconButton(
                                  onPressed: () => _getDateFromUser(),
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Expanded(
                              child: InputField(
                                title: "Time",
                                hint: time,
                                widget: IconButton(
                                  onPressed: () => _getTimeFromUser(),
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        pickedImage == null? GestureDetector(
                          onTap: fetchImage,
                          child: const UploadImg()
                          ) : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child:  Image.file(pickedImage!,fit: BoxFit.cover,height: 190,width: double.infinity),
                            ),
                          )
                          ,
                      ],
                    ),
                  ),
            ));
        },
        child: const Icon(
          Icons.image,
          color: Colors.grey,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(249, 249, 224, 1),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Color.fromRGBO(255, 192, 217, 1), blurRadius: 9)
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              onTabChange: (newIndex) {
                setState(() {
                  _selectedIndex = newIndex;
                });
              },
              gap: 10,
              activeColor: Colors.grey,
              tabActiveBorder:
                  Border.all(color: const Color.fromRGBO(255, 192, 217, 1)),
              duration: const Duration(milliseconds: 600),
              tabBorderRadius: 15,
              tabBackgroundColor: const Color.fromRGBO(190, 231, 237, 1),
              iconSize: 16,
              curve: Curves.easeInCubic,
              color: Colors.grey,
              tabs: <GButton>[
                GButton(
                  icon: Icons.home,
                  text: "Home",
                  textStyle: GoogleFonts.aDLaMDisplay(color: Colors.grey),
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: "Favorite",
                  textStyle: GoogleFonts.aDLaMDisplay(color: Colors.grey),
                ),
                GButton(
                  icon: Icons.archive,
                  text: "Archived",
                  textStyle: GoogleFonts.aDLaMDisplay(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase("memories.db", version: 1,
        onCreate: (database, version) {
      print("database created!");
      database
          .execute(
              "CREATE TABLE memory (id INTEGER PRIMARY KEY,title TEXT,descreption TEXT,img TEXT,date TEXT,time TEXT,status TEXT)")
          .then((value) {
        print("tablr created!");
      }).catchError((error) {
        print("Error whem creating table ${error.toString()}");
      });
    }, onOpen: (database) {
      print("database Opened!");
    });
  }
/* 
  void insertToDatabase() {
    database.transaction((txn) {
      txn
          .rawInsert(
              "INSERT INTO memory(title,descreption,img,date,time,status)  VALUES('first','desc','kjk','123','22','fav')")
          .then((value) {
        print("$value inserted successfully!");
      }).catchError((error) {
        print("Error when inserting new record $error");
      });
      return null;
    });
  } */

  _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    } else {
      print("IT'S NULL OR SOMETHING IS WRONG!!");
    }
  }

  _getTimeFromUser() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);

      setState(() {
        time = formattedTime;
      });
    } else {
      print("It's Null");
    }
  }

  final ImagePicker picker = ImagePicker();
  File? pickedImage;
  ImageProvider<Object>? imageProvider;

  fetchImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(image.path);
      imageProvider = FileImage(pickedImage!);
    });
  }

  
}
