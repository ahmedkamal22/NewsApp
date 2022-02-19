import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isDark = CacheHelper.getBooleanData(key: "isDark");
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.int();
  await CacheHelper.int();
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HexColor color = HexColor("333739");
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsAppCubit()..changeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => NewsAppCubit()
            ..getBusinessData()
            ..getSportsData()
            ..getScienceData()
            ..getTechnologyData()
            ..getHealthData(),
        ),
      ],
      child: BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsAppCubit cubit = NewsAppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                iconColor: Colors.black,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                iconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  type: BottomNavigationBarType.fixed,
                  elevation: 30.0,
                  backgroundColor: Colors.white),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                iconColor: Colors.grey,
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              scaffoldBackgroundColor: color,
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                color: color,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                iconTheme: IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: color,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                type: BottomNavigationBarType.fixed,
                elevation: 30.0,
                backgroundColor: color,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: Home(),
          );
        },
      ),
    );
  }
}

