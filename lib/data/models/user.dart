import 'dart:convert';

import 'package:auth_clean_architecture/domain/entities/user.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String email;
  final String username;
  UserModel({
    required this.email,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
    );
  }
}
