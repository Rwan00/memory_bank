import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_bank/cubit/app_cubit/app_cubit.dart';
import 'package:memory_bank/cubit/app_cubit/app_state.dart';

class MemoryDetailsScreen extends StatelessWidget {
  final Map model;

  const MemoryDetailsScreen({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    File img = File(model["img"]);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(250, 240, 230, 1),
          appBar: AppBar(
            title: Text(
              "Details",
              style: GoogleFonts.aDLaMDisplay(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(53, 47, 68, 1),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(53, 47, 68, 1),
                              Color.fromRGBO(92, 84, 112, 1),
                              Color.fromRGBO(185, 180, 199, 1),
                              Color.fromRGBO(92, 84, 112, 1),
                              Color.fromRGBO(53, 47, 68, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      width: 250,
                      child: Center(
                        child: Text(
                          model["title"],
                          style: GoogleFonts.aDLaMDisplay(
                              color: Colors.white, fontSize: 24),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 300,
                      width: double.infinity,
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            img,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: GoogleFonts.aDLaMDisplay(fontSize: 24),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          model["description"],
                          style: GoogleFonts.aDLaMDisplay(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cubit.updateData(status: "fav", id: model["id"]);
                        cubit.changeLikeState();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 8)),
                      ),
                      child: Icon(
                        cubit.isLike ? Icons.favorite : Icons.favorite_border,
                        color:
                            cubit.isLike ? Colors.red[200] : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.updateData(status: "archived", id: model["id"]);
                          cubit.changeArchivedState();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 8)),
                        ),
                        child: Icon(
                          cubit.isArchived
                              ? Icons.archive
                              : Icons.archive_outlined,
                          color: cubit.isArchived
                              ? Colors.green[200]
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
