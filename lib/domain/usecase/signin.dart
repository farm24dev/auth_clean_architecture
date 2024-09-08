import 'package:auth_clean_architecture/core/usecase/usecase.dart';
import 'package:auth_clean_architecture/data/models/signin_req_params.dart';
import 'package:auth_clean_architecture/domain/repository/auth.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:dartz/dartz.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
}
