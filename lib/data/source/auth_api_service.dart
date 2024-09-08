import 'dart:developer';

import 'package:auth_clean_architecture/core/network/dio_client.dart';
import 'package:auth_clean_architecture/core/constants/api_urls.dart';
import 'package:auth_clean_architecture/data/models/signup_req_params.dart';
import 'package:auth_clean_architecture/data/models/signin_req_params.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthApiService {
  Future<Either> signup(SignupReqParams signupReq);
  Future<Either> signin(SigninReqParams signinReq);
  Future<Either> getUser();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try {
      var response = await sl<DioClient>().post(ApiUrls.register, data: signupReq.toMap());
      log('AuthApiServiceImpl -> ${response.data}');
      log('AuthApiServiceImpl -> ${response.data?['token']}');
      return Right(response);
    } on DioException catch (e) {
      log('AuthApiServiceImpl DioException -> $e');
      return Left(e.response?.data['message']);
    } catch (error) {
      log('AuthApiServiceImpl catch-> $error');
      return Left(error);
    }
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      var response = await sl<DioClient>().post(ApiUrls.login, data: signinReq.toMap());
      log('AuthApiServiceImpl -> ${response.data}');
      log('AuthApiServiceImpl -> ${response.data?['token']}');
      return Right(response);
    } on DioException catch (e) {
      log('AuthApiServiceImpl DioException -> $e');
      return Left(e.response?.data['message']);
    } catch (error) {
      log('AuthApiServiceImpl catch-> $error');
      return Left(error);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString('token');
      var response = await sl<DioClient>().get(
        ApiUrls.userProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Right(response);
    } on DioException catch (e) {
      log('AuthApiServiceImpl DioException -> $e');
      return Left(e.response?.data['message']);
    } catch (error) {
      log('AuthApiServiceImpl catch-> $error');
      return Left(error);
    }
  }
}
