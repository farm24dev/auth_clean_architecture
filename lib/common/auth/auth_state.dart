part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {}

final class UnAuthenticated extends AuthState {}
