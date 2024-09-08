import 'dart:developer';

import 'package:auth_clean_architecture/common/button/button_state.dart';
import 'package:auth_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitalState());

  void excute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    try {
      Either result = await usecase.call(param: params);

      log('result -> ${result}');

      result.fold((error) {
        emit(ButtonFailureState(errorMessage: error));
      }, (data) {
        emit(ButtonSuccessState());
      });
    } catch (e) {
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
