import 'dart:developer';

import 'package:auth_clean_architecture/common/button/button_state.dart';
import 'package:auth_clean_architecture/common/button/button_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({super.key, required this.title, this.height, this.width, required this.onPressed});
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        log('state -> ${state}');
        if (state is ButtonLoadingState) {
          return _loading(context);
        }
        return _initial(context);
      },
    );
  }

  Widget _loading(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.grey,
        minimumSize: Size(width ?? MediaQuery.of(context).size.width, height ?? 60),
      ),
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget _initial(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
        BoxShadow(
          color: const Color(0xff3461FD).withOpacity(0.8),
          offset: const Offset(0, 5),
          blurRadius: 17,
        )
      ]),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(width ?? MediaQuery.of(context).size.width, height ?? 60),
          ),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          )),
    );
  }
}
