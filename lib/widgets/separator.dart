import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 390,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 192, 217, 0.7),
              Color.fromRGBO(138, 205, 215, 0.7),
              Color.fromRGBO(249, 249, 224, 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror),
      ),
    );
  }
}