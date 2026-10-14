import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user_model.dart';
import 'database_helper.dart';

class AuthService {
  final _dbHelper = DatabaseHelper.instance;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final db = await _dbHelper.database;

    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (existing.isNotEmpty) {
      throw Exception('This email is already registered');
    }

    final user = UserModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name.trim(),
      email: email.toLowerCase().trim(),
      passwordHash: _hashPassword(password),
    );

    await db.insert('users', user.toMap());
    return user;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND passwordHash = ?',
      whereArgs: [email.toLowerCase().trim(), _hashPassword(password)],
    );

    if (result.isEmpty) {
      throw Exception('Invalid email or password');
    }
    return UserModel.fromMap(result.first);
  }
}