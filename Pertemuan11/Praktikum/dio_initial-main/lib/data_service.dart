import 'package:dio/dio.dart';

import 'user.dart';

class DataService {
  final Dio dio = Dio();
  final String _baseUrl = 'https://reqres.in';

  Future<List<User>?> getUsers() async {
    try {
      Response response = await dio.get('$_baseUrl/api/users');
      if (response.statusCode == 200) {
        final users = (response.data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();
        return users;
      }
      return null;
    } catch (e) {
      // Handle error (logging, return specific error message, etc.)
      rethrow;
    }
  }

  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      final response =
          await dio.post('$_baseUrl/api/users', data: user.toJson());

      if (response.statusCode == 201) {
        return UserCreate.fromJson(response.data);
      }
      return null;
    } catch (e) {
      // Handle error (logging, return specific error message, etc.)
      rethrow;
    }
  }

  Future<UserPut?> putUser(UserPut user) async {
    try {
      final response =
          await dio.put('$_baseUrl/api/users/${user.id}', data: user.toJson());

      if (response.statusCode == 200) {
        return UserPut.fromJson(response.data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> deleteUser(String idUser) async {
    try {
      Response response = await dio.delete('$_baseUrl/api/users/$idUser');

      if (response.statusCode == 204) {
        return "Data Dihapus Cuyyy";
      }
      return null;
    } catch (e) {
      // Handle error (logging, return specific error message, etc.)
      rethrow;
    }
  }

  Future<List<User>?> getUserModel() async {
    try {
      Response response = await dio.get('$_baseUrl/api/users');
      if (response.statusCode == 200) {
        final users = (response.data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();
        return users;
      }
      return null;
    } catch (e) {
      // Handle error (logging, return specific error message, etc.)
      rethrow;
    }
  }
}
