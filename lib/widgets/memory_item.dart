import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../database/db_helper.dart';

class MemoryItem extends StatelessWidget {
  final Map model;
  const MemoryItem({ required this.model,super.key});

  @override
  Widget build(BuildContext context) {
    File img = File(model["img"]);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      shadowColor: const Color.fromRGBO(138, 205, 215, 0.7),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.file(
                  img,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15,
                right: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 192, 217, 0.7),
                          Color.fromRGBO(138, 205, 215, 0.7),
                          Color.fromRGBO(249, 249, 224, 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  width: 250,
                  child: Text(
                    model["title"],
                    style: GoogleFonts.aDLaMDisplay(
                        color: Colors.white, fontSize: 16),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_month,color: Colors.grey,),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      model["date"],
                      style: GoogleFonts.aDLaMDisplay(
                          color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.access_time_outlined,color: Colors.grey,),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      model["time"],
                      style: GoogleFonts.aDLaMDisplay(
                          color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
