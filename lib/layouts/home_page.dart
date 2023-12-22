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
      backgroundColor:const Color.fromRGBO(250, 240, 230,1),
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          _pages[_selectedIndex]["title"],
          style: GoogleFonts.aDLaMDisplay(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(53, 47, 68,1),
      ),
      body: ConditionalBuilder(
        condition: memories.isNotEmpty,
        builder: (context)=> _pages[_selectedIndex]["page"],
        fallback: (context) => const Center(child: CircularProgressIndicator(),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(53, 47, 68,1),
        onPressed: () {
          scaffoldKey.currentState!
              .showBottomSheet((context) => const BottomSheetBody());
        },
        child: const Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          //color: Color.fromRGBO(53, 47, 68,0.8),
          boxShadow: <BoxShadow>[
            BoxShadow(color: const Color.fromRGBO(53, 47, 68,1), blurRadius: 9)
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
              activeColor: Colors.white,
              tabActiveBorder:
                  Border.all(color: const Color.fromRGBO(250, 240, 230,1)),
              duration: const Duration(milliseconds: 600),
              tabBorderRadius: 15,
              //tabBackgroundColor: const Color.fromRGBO(92, 84, 112,0.6),
              iconSize: 16,
              curve: Curves.easeInCubic,
              color: Colors.white,
              tabs: <GButton>[
                GButton(
                  icon: Icons.home,
                  iconColor: Colors.white,
                  iconSize: 24,
                  text: "Home",
                  textStyle: GoogleFonts.aDLaMDisplay(color: Colors.white),
                ),
                GButton(
                  icon: Icons.favorite_border,
                  iconColor: Colors.white,
                  iconSize: 24,
                  text: "Favorite",
                  textStyle: GoogleFonts.aDLaMDisplay(color: Colors.white),
                ),
                GButton(
                  icon: Icons.archive,
                  iconColor: Colors.white,
                  iconSize: 24,
                  text: "Archived",
                  textStyle: GoogleFonts.aDLaMDisplay(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
