import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://your-api-url.com'; 

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Login failed: ${res.body}");
    }
  }

  static Future<Map<String, dynamic>> register(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("register failed: ${res.body}");
    }
  }

  static Future<void> changePassword(String email, String oldPassword, String newPassword) async {
    final res = await http.post(
      Uri.parse('$baseUrl/change-password'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "oldPassword": oldPassword,
        "newPassword": newPassword
      }),
    );
    if (res.statusCode != 200) {
      throw Exception("change-password failed: ${res.body}");
    }
  }
}