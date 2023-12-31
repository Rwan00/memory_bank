import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:memory_bank/cubit/app_cubit/app_cubit.dart';
import 'package:memory_bank/cubit/app_cubit/app_state.dart';
import '../widgets/bottom_sheet_body.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: const Color.fromRGBO(250, 240, 230, 1),
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              cubit.pages[cubit.selectedIndex]["title"],
              style: GoogleFonts.aDLaMDisplay(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(53, 47, 68, 1),
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDatabaseLoadingState,
            builder: (context) => cubit.pages[cubit.selectedIndex]["page"],
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(53, 47, 68, 1),
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
              boxShadow: <BoxShadow>[
                BoxShadow(color: Color.fromRGBO(53, 47, 68, 1), blurRadius: 9)
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GNav(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  onTabChange: (newIndex) {
                    cubit.changeIndex(newIndex);
                  },
                  gap: 10,
                  activeColor: Colors.white,
                  tabActiveBorder:
                      Border.all(color: const Color.fromRGBO(250, 240, 230, 1)),
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
      },
    );
  }
}
