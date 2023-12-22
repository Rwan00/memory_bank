
import 'package:memory_bank/cubit/app_cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/archived_screen.dart';
import '../../views/favourites_screen.dart';
import '../../views/memories_screen.dart';

class AppCubit extends Cubit<AppStates>{
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

  void changeIndex(int index){
    selectedIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}