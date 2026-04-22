import 'package:bloc_api/bloc/user_event.dart';
import 'package:bloc_api/bloc/user_state.dart';
import 'package:bloc_api/model/user_model.dart';
import 'package:bloc_api/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<UserModel> userModelList = [];
  UserBloc() : super(UserInit()) {
    ApiService _apiService = ApiService();
    on<GetAllUserList>((event, emit) async {
      try {
        emit(UserLoading());
        userModelList = await _apiService.getData();
        emit(UserDataLoaded(userModelList));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
