import 'package:auth_clean_architecture/common/auth/auth_cubit.dart';
import 'package:auth_clean_architecture/core/configs/theme/app_theme.dart';
import 'package:auth_clean_architecture/presentation/auth/signin_page.dart';
import 'package:auth_clean_architecture/presentation/home/pages/home_page.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ),
  );

  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );

    return BlocProvider(
      create: (context) => AuthCubit()..appStarted(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomePage();
            }
            if (state is UnAuthenticated) {
              return SigninPage();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
