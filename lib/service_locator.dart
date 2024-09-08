import 'package:auth_clean_architecture/core/network/dio_client.dart';
import 'package:auth_clean_architecture/data/repository/auth.dart';
import 'package:auth_clean_architecture/data/source/auth_api_service.dart';
import 'package:auth_clean_architecture/data/source/auth_local_service.dart';
import 'package:auth_clean_architecture/domain/repository/auth.dart';
import 'package:auth_clean_architecture/domain/usecase/get_user.dart';
import 'package:auth_clean_architecture/domain/usecase/is_logged_in.dart';
import 'package:auth_clean_architecture/domain/usecase/logout.dart';
import 'package:auth_clean_architecture/domain/usecase/signin.dart';
import 'package:auth_clean_architecture/domain/usecase/signup.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(
    DioClient(),
  );

  //Service
  sl.registerSingleton<AuthApiService>(
    AuthApiServiceImpl(),
  );

  sl.registerSingleton<AuthLocalService>(
    AuthLocalServiceImpl(),
  );

  //Reposotories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );

  //Usecase
  sl.registerSingleton<SignupUseCase>(
    SignupUseCase(),
  );

  sl.registerSingleton<IsLoggedInUseCase>(
    IsLoggedInUseCase(),
  );

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(),
  );

  sl.registerSingleton<LogoutUseCase>(
    LogoutUseCase(),
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase(),
  );
}
