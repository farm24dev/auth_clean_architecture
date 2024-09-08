import 'package:auth_clean_architecture/domain/usecase/logout.dart';
import 'package:auth_clean_architecture/presentation/auth/signin_page.dart';
import 'package:auth_clean_architecture/presentation/auth/signup_page.dart';
import 'package:auth_clean_architecture/presentation/home/bloc/user_display/user_display_cubit.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserDisplayCubit()..displayUser(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'HomePage',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await sl<LogoutUseCase>().call();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(),
                    ));
              },
              color: Colors.white,
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: BlocBuilder<UserDisplayCubit, UserDisplayState>(
          builder: (context, state) {
            if (state is UserDisplayLoading) {
              return const CircularProgressIndicator.adaptive();
            }
            if (state is UserDisplayFailure) {
              return Text(state.errorMessage);
            }
            if (state is UserDisplaySuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('username : ${state.userEntity.username}'),
                    const SizedBox(height: 10),
                    Text('email : ${state.userEntity.email}'),
                  ],
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
