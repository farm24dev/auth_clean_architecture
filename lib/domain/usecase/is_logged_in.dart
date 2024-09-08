import 'package:auth_clean_architecture/core/usecase/usecase.dart';
import 'package:auth_clean_architecture/domain/repository/auth.dart';
import 'package:auth_clean_architecture/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
