import 'package:auth_clean_architecture/data/models/signup_req_params.dart';
import 'package:auth_clean_architecture/data/models/signin_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signin);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
  Future<void> logout();
}
