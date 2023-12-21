import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:memory_bank/views/archived_screen.dart';
import 'package:memory_bank/views/favourites_screen.dart';
import 'package:memory_bank/views/memories_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../database/db_helper.dart';
import '../widgets/bottom_sheet_body.dart';
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


  var scaffoldKey = GlobalKey<ScaffoldState>();

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
      backgroundColor:const Color.fromRGBO(226, 243, 241, 1.0),
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex]["title"],
          style: GoogleFonts.aDLaMDisplay(color: Colors.grey),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(249, 249, 224, 1),
      ),
      body: ConditionalBuilder(
        condition: memories.isNotEmpty,
        builder: (context)=> _pages[_selectedIndex]["page"],
        fallback: (context) => const Center(child: CircularProgressIndicator(),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldKey.currentState!
              .showBottomSheet((context) => const BottomSheetBody());
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


}
