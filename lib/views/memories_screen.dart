import 'package:flutter/material.dart';
import 'package:memory_bank/database/db_helper.dart';
import 'package:memory_bank/widgets/memory_item.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
      itemCount: memories.length,
        itemBuilder: (ctx,index){
      return  MemoryItem(model: memories[index],);
    });
  }
}