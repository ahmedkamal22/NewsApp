abstract class NewsAppStates {}

class InitialState extends NewsAppStates {}

class BottomNavIndexState extends NewsAppStates {}

class GetBusinessSuccessState extends NewsAppStates {}

class GetBusinessFailureState extends NewsAppStates {
  final String error;

  GetBusinessFailureState(this.error);
}

class GetBusinessLoadingState extends NewsAppStates {}

class GetSportsSuccessState extends NewsAppStates {}

class GetSportsFailureState extends NewsAppStates {
  final String error;

  GetSportsFailureState(this.error);
}

class GetSportsLoadingState extends NewsAppStates {}

class GetScienceSuccessState extends NewsAppStates {}

class GetScienceFailureState extends NewsAppStates {
  final String error;

  GetScienceFailureState(this.error);
}

class GetScienceLoadingState extends NewsAppStates {}

//
class GetTechnologySuccessState extends NewsAppStates {}

class GetTechnologyFailureState extends NewsAppStates {
  final String error;

  GetTechnologyFailureState(this.error);
}

class GetTechnologyLoadingState extends NewsAppStates {}
