import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
        emit(ChangeAppState());
      });
    }
  }
}
