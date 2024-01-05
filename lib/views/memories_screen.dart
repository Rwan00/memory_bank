import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memory_bank/cubit/app_cubit/app_cubit.dart';
import 'package:memory_bank/cubit/app_cubit/app_state.dart';
import 'package:memory_bank/widgets/memory_item.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
   
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.memories.isNotEmpty,
            builder: (context){
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 210,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 1,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.memories.length,
                itemBuilder: (ctx, index) {
                  return MemoryItem(
                    model: cubit.memories[index],
                  );
                },
              );
            },
            fallback: (context){
              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image_outlined,color: Colors.grey,size: 64,),
                    Text("No Memories Yet,Start Add",style: GoogleFonts.aDLaMDisplay(fontSize: 16,color: Colors.grey),)
                  ],
                ),
              );
            },
        );
      },
    );
  }
}
