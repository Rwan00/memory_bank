import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_bank/widgets/separator.dart';

import '../database/db_helper.dart';
import '../methods/navigator.dart';
import '../views/memory_detailes_screen.dart';

class MemoryItem extends StatelessWidget {
  final Map model;
  const MemoryItem({ required this.model,super.key});

  @override
  Widget build(BuildContext context) {
    File img = File(model["img"]);
    return GestureDetector(
      onTap: (){
        navigateTo(context,MemoryDetailsScreen(model: model,));
      },
      child: Card(
        color:const Color.fromRGBO(185, 180, 199,0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        shadowColor: const Color.fromRGBO(53, 47, 68,1),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius:  BorderRadius.circular(
                    15
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
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 24),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(53, 47, 68,1),
                            Color.fromRGBO(92, 84, 112,1),
                            Color.fromRGBO(185, 180, 199,1),
                            Color.fromRGBO(250, 240, 230,1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    width: 150,
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
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.calendar_month,color: Colors.white,size: 12,),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        model["date"],
                        style: GoogleFonts.aDLaMDisplay(
                            color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.access_time_outlined,color: Colors.white,size: 14,),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        model["time"],
                        style: GoogleFonts.aDLaMDisplay(
                            color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Separator(),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    model["description"],
                    style: GoogleFonts.aDLaMDisplay(
                        color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
