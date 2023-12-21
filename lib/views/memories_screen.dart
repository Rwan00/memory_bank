import 'package:flutter/material.dart';
import 'package:memory_bank/widgets/memory_item.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
      itemCount: 8,
        itemBuilder: (ctx,index){
      return const MemoryItem();
    });
  }
}