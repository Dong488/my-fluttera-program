import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/SPManager.dart';
import '../utils/ToastUtil.dart';

class ApiService {
  static const String baseUrl = "https://your-api-url.com";

  Future<http.Response> postRequest(String endpoint, Map<String, dynamic> body) async {
  final token = SPManager.instance.getToken();
  final response = await http.post(
    Uri.parse('$baseUrl$endpoint'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );
  return response;
}
  // login
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
        ToastUtil.toast('Login successful');
        return true;
      } else {
        ToastUtil.toast('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      ToastUtil.toast('Error: $e');
      return false;
    }
  }

  // regist
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
        ToastUtil.toast('Registration successful');
        return true;
      } else {
        ToastUtil.toast('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      ToastUtil.toast('Error: $e');
      return false;
    }
  }

  // changepassword
  static Future<bool> changePassword(String email, String oldPassword, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/change-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'oldPassword': oldPassword, 'newPassword': newPassword}),
      );

      if (response.statusCode == 200) {
        ToastUtil.toast('Password changed successfully');
        return true;
      } else {
        ToastUtil.toast('Failed to change password: ${response.body}');
        return false;
      }
    } catch (e) {
      ToastUtil.toast('Error: $e');
      return false;
    }
  }
}
