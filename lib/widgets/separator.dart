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
              Color.fromRGBO(53, 47, 68,1),
              Color.fromRGBO(92, 84, 112,1),
              Color.fromRGBO(185, 180, 199,1),
              Color.fromRGBO(250, 240, 230,1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror),
      ),
    );
  }
}