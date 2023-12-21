import 'package:flutter/material.dart';
import 'package:memory_bank/database/db_helper.dart';
import 'package:memory_bank/widgets/memory_item.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 210,
        childAspectRatio: 0.6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 1,
      ),
        physics: const BouncingScrollPhysics(),
      itemCount: memories.length,
        itemBuilder: (ctx,index){
      return  MemoryItem(model: memories[index],);
    }, );
  }
}