import 'package:flutter/material.dart';

import 'layouts/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(53, 47, 68,1),
          primary: const Color.fromRGBO(53, 47, 68,1),
        secondary: const Color.fromRGBO(250, 240, 230,1),),
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}
