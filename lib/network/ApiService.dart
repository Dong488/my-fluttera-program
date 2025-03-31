import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/SPManager.dart';
import '../utils/ToastUtil.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-url.com';

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        SPManager.instance.saveToken(data['token']);
        SPManager.instance.saveUserId(data['userId']);
        ToastUtil.toast('Login Successful');
        return true;
      } else {
        ToastUtil.toast('Login Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      ToastUtil.toast('Error: $e');
      return false;
    }
  }

  static Future<bool> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        SPManager.instance.saveToken(data['token']);
        SPManager.instance.saveUserId(data['userId']);
        ToastUtil.toast('Registration Successful');
        return true;
      } else {
        ToastUtil.toast('Registration Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      ToastUtil.toast('Error: $e');
      return false;
    }
  }

  static Future<bool> changePassword(String email, String oldPassword, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/change-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'oldPassword': oldPassword, 'newPassword': newPassword}),
      );

      if (response.statusCode == 200) {
        ToastUtil.toast('Password Changed Successfully');
        return true;
      } else {
        ToastUtil.toast('Password Change Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      ToastUtil.toast('Error: $e');
      return false;
    }
  }
}
