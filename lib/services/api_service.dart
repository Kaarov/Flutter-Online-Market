import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  final String baseUrl = 'https://' + 'a1c4-212-112-119-232.ngrok-free.app';

  // Future fetchData() async {
  //   Map<String, String> requestHeaders = {
  //       'content-type': 'application/json',
  //       'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAxNjA3MzM4LCJpYXQiOjE3MDE2MDM3MzgsImp0aSI6IjkwYjE3YTBiNjU0YzQwOGZhZTkwZjY0MGI2NTlmNDM4IiwidXNlcl9pZCI6Mn0.ZYMsT7X0G0sXMpygZU5vVm9-5LsWgGiANg93a2eho94'
  //     };
  //
  //   final response = await http.get(Uri.parse('https://5b06-212-112-119-232.ngrok-free.app/user/profile/'), headers: requestHeaders);
  //
  //   print(response.body);

  Future<String?> singUp(String username, String email, String password, String passwordConfirm) async {

    final response = await http.post(
        Uri.parse('$baseUrl/user/register/'),
        body: {
          "username": username,
          "email": email,
          "password": password,
          "password2": passwordConfirm
        }
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String? token = data['access'];

      if (token != null) {
        await saveToken(token);
        return token;
      }
    }

    return null;
  }

  Future<String?> login(String username, String password) async {

    final response = await http.post(
        Uri.parse('$baseUrl/user/login/'),
        body: {"username": username, "password": password}
    );
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String? token = data['access'];
      print(token);

      if (token != null) {
        await saveToken(token);
        // String? getJwtToken = await getToken();
        // print(getJwtToken);
        return token;
      }
    }

    return null;
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
