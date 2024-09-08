import 'package:auth_clean_architecture/core/usecase/usecase.dart';
import 'package:auth_clean_architecture/data/models/signup_req_params.dart';
import 'package:auth_clean_architecture/domain/repository/auth.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:dartz/dartz.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}
