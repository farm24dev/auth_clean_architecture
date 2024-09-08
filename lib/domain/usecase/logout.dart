import 'package:auth_clean_architecture/core/usecase/usecase.dart';
import 'package:auth_clean_architecture/domain/repository/auth.dart';
import 'package:auth_clean_architecture/service_locator.dart';

class LogoutUseCase implements UseCase<dynamic, dynamic> {
  @override
  Future<dynamic> call({dynamic param}) async {
    return sl<AuthRepository>().logout();
  }
}
