import 'package:auth_clean_architecture/core/usecase/usecase.dart';
import 'package:auth_clean_architecture/domain/repository/auth.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<AuthRepository>().getUser();
  }
}
