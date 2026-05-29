import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService {
  static const _kUsersKey = 'users';

  Future<List<UserModel>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_kUsersKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    final List decoded = jsonDecode(data) as List;
    return decoded
        .map((e) => UserModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  /// Signup returns `false` when the email already exists, `true` on success.
  Future<bool> signup(
    String name,
    String email,
    String phone,
    String password,
    String gender,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();

    // Prevent duplicate registration for the same email
    if (users.any((u) => u.email == email)) {
      return false;
    }

    users.add(
      UserModel(
        email: email,
        password: password,
        name: name.isEmpty ? null : name,
        phone: phone.isEmpty ? null : phone,
        gender: gender.isEmpty ? null : gender,
      ),
    );

    final jsonList = users.map((u) => u.toJson()).toList();
    await prefs.setString(_kUsersKey, jsonEncode(jsonList));

    return true;
  }

  /// Returns `true` if an email/password pair matches an existing user.
  Future<bool> login(String email, String password) async {
    final users = await getUsers();
    return users.any((u) => u.email == email && u.password == password);
  }
}
