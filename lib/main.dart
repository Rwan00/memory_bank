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
          seedColor: const Color.fromRGBO(255, 192, 217, 1),
          primary: const Color.fromRGBO(138, 205, 215,1),
        secondary: const Color.fromRGBO(138, 205, 215,1)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
