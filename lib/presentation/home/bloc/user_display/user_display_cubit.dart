import 'package:auth_clean_architecture/domain/entities/user.dart';
import 'package:auth_clean_architecture/domain/usecase/get_user.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_display_state.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserDisplayInitial());

  void displayUser() async {
    var result = await sl<GetUserUseCase>().call();
    result.fold((error) {
      emit(UserDisplayFailure(errorMessage: error));
    }, (data) {
      emit(UserDisplaySuccess(userEntity: data));
    });
  }
}
