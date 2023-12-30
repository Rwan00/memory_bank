import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/app_cubit/app_cubit.dart';
import 'cubit/bloc_observer.dart';
import 'layouts/home_page.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(53, 47, 68, 1),
            primary: const Color.fromRGBO(53, 47, 68, 1),
            secondary: const Color.fromRGBO(250, 240, 230, 1),
          ),
          useMaterial3: true,
        ),
        home:  HomePage(),
      ),
    );
  }
}
