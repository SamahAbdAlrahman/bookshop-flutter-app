import 'package:dio/dio.dart';

import '../constants/api_routes.dart';

class AuthAPI {
  // login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final dio = Dio();

    try {
      final response = await dio.post(ApiRoutes.login, data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Invalid email or password');
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }


//   register
  static Future<Map<String, dynamic>> register(String name, String email, String password, String passwordConfirmation) async {
    final dio = Dio();

    try {
      final response = await dio.post(ApiRoutes.register, data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Registration failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
// forgetPassword
  static Future<Map<String, dynamic>> forgetPassword(String email) async {
    final dio = Dio();

    try {
      final response = await dio.post(ApiRoutes.forgetPassword, data: {
        'email': email,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to send reset code');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
// /code

  static Future<Map<String, dynamic>> checkForgetPassword(String email, String verifyCode) async {
    final dio = Dio();

    try {
      final response = await dio.post(ApiRoutes.checkForgetPassword, data: {
        'email': email,
        'verify_code': verifyCode,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Verification failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
// reset padd
  static Future<Map<String, dynamic>> resetPassword(String email, String verifyCode, String newPassword, String confirmPassword) async {
    final dio = Dio();

    try {
      final response = await dio.post(ApiRoutes.resetPassword, data: {
        'email': email,
        'verify_code': verifyCode,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Reset password failed');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


}
