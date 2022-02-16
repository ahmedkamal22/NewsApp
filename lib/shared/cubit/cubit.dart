import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/settings/settings.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/modules/technology/technology.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(InitialState());

  static NewsAppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    Business(),
    Sports(),
    Science(),
    Technology(),
    Settings(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(
        icon: Icon(Icons.computer_rounded), label: "Technology"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavIndexState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(GetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": myApiKey,
    }).then((value) {
      business = value.data["articles"];
      print(business[0]["title"]);
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessFailureState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    emit(GetSportsLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "sports",
      "apiKey": myApiKey,
    }).then((value) {
      sports = value.data["articles"];
      print(sports[0]["title"]);
      emit(GetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSportsFailureState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getScienceData() {
    emit(GetScienceLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "science",
      "apiKey": myApiKey,
    }).then((value) {
      science = value.data["articles"];
      print(science[0]["title"]);
      emit(GetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetScienceFailureState(error.toString()));
    });
  }

  List<dynamic> technology = [];

  void getTechnologyData() {
    emit(GetTechnologyLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "technology",
      "apiKey": myApiKey,
    }).then((value) {
      technology = value.data["articles"];
      print(technology[0]["title"]);
      emit(GetTechnologySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTechnologyFailureState(error.toString()));
    });
  }
}
