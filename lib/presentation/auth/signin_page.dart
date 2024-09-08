import 'package:auth_clean_architecture/common/button/button_state.dart';
import 'package:auth_clean_architecture/common/button/button_state_cubit.dart';
import 'package:auth_clean_architecture/common/widgets/button/button_custom.dart';
import 'package:auth_clean_architecture/core/network/interceptors.dart';
import 'package:auth_clean_architecture/data/models/signin_req_params.dart';
import 'package:auth_clean_architecture/domain/usecase/signin.dart';
import 'package:auth_clean_architecture/presentation/auth/signup_page.dart';
import 'package:auth_clean_architecture/presentation/home/pages/home_page.dart';
import 'package:auth_clean_architecture/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailController = TextEditingController(text: 'tester@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '123123');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            if (state is ButtonFailureState) {
              LoggerInterceptor().logger.e(state.errorMessage);
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _signin(),
                  const SizedBox(height: 50),
                  _emailField(),
                  const SizedBox(height: 20),
                  _password(),
                  const SizedBox(height: 60),
                  _signinButton(context),
                  const SizedBox(height: 20),
                  _signupText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signin() {
    return const Text(
      'Sign In',
      style: TextStyle(color: Color(0xff2A4ECA), fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _password() {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _signinButton(BuildContext context) {
    return Builder(builder: (context) {
      return ButtonCustom(
        title: 'Sign In',
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          context.read<ButtonStateCubit>().excute(
                usecase: sl<SigninUseCase>(),
                params: SigninReqParams(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
        },
      );
    });
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(text: "Don't you have account?", style: TextStyle(color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign Up',
            style: const TextStyle(color: Color(0xff3461FD), fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ));
              })
      ]),
    );
  }
}
