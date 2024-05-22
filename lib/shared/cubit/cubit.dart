import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/health/health.dart';
import 'package:news_app/modules/science/science.dart';
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
    const Business(),
    const Sports(),
    const Science(),
    const Technology(),
    const Health(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.computer_rounded), label: "Technology"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.health_and_safety_outlined), label: "Health"),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavIndexState());
  }

  List<dynamic> business = [];
  int selectedTitle = 0;

  void getBusinessData() {
    emit(GetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "business",
      "apiKey": myApiKey,
    }).then((value) {
      business = value.data["articles"];
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
      "country": "us",
      "category": "sports",
      "apiKey": myApiKey,
    }).then((value) {
      sports = value.data["articles"];
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
      "country": "us",
      "category": "science",
      "apiKey": myApiKey,
    }).then((value) {
      science = value.data["articles"];
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
      "country": "us",
      "category": "technology",
      "apiKey": myApiKey,
    }).then((value) {
      technology = value.data["articles"];
      emit(GetTechnologySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTechnologyFailureState(error.toString()));
    });
  }

  List<dynamic> health = [];

  void getHealthData() {
    emit(GetHealthLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "health",
      "apiKey": myApiKey,
    }).then((value) {
      health = value.data["articles"];
      emit(GetHealthSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHealthFailureState(error.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(GetSearchLoadingState());
    DioHelper.getData(url: "v2/everything", query: {
      "q": value,
      "apiKey": myApiKey,
    }).then((value) {
      search = value.data["articles"];
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchFailureState(error.toString()));
    });
  }
}
