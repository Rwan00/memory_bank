import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_bank/cubit/app_cubit/app_cubit.dart';
import 'package:memory_bank/cubit/app_cubit/app_state.dart';
import 'package:memory_bank/widgets/memory_item.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 210,
            childAspectRatio: 0.6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 1,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.archivedMemories.length,
          itemBuilder: (ctx, index) {
            return MemoryItem(
              model: cubit.archivedMemories[index],
            );
          },
        );
      },
    );
  }
}
