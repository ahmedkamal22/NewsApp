import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit()
        ..getBusinessData()
        ..getSportsData()
        ..getScienceData()
        ..getTechnologyData()
        ..getHealthData(),
      child: BlocConsumer<NewsAppCubit, NewsAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            NewsAppCubit cubit = NewsAppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text("News App"),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        cubit.changeMode();
                      },
                      icon: Icon(Icons.brightness_4_outlined)),
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
          }),
    );
  }
}
