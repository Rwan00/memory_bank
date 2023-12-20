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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(41, 110, 120, 0.6)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
