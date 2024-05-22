import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsAppCubit cubit = NewsAppCubit.get(context);
          AppCubit appCubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("News App"),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, Search());
                    },
                    icon: const Icon(Icons.search)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: cubit.items,
            ),
          );
        });
  }
}
