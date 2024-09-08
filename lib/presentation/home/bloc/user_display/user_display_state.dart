part of 'user_display_cubit.dart';

sealed class UserDisplayState {}

final class UserDisplayInitial extends UserDisplayState {}

final class UserDisplayLoading extends UserDisplayState {}

final class UserDisplaySuccess extends UserDisplayState {
  final UserEntity userEntity;
  UserDisplaySuccess({required this.userEntity});
}

final class UserDisplayFailure extends UserDisplayState {
  final String errorMessage;
  UserDisplayFailure({required this.errorMessage});
}
