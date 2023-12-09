import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_market/models/card_models.dart';


class ApiService {

  final String baseUrl = 'https://' + 'e00b-212-42-113-145.ngrok-free.app';

  Future headersAuthorization() async {
    String? getJwtToken = await getToken();

    Map<String, String> requestHeaders = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $getJwtToken',
    };

    return requestHeaders;
  }

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

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String? token = data['access'];

      if (token != null) {
        await saveToken(token);
        // String? getJwtToken = await getToken();
        // print(getJwtToken);
        return token;
      }
    }

    return null;
  }

  Future<List<Order>> get_card_api() async {
    Map<String, String> headersUrl = await headersAuthorization();

    final response = await http.get(
        Uri.parse('$baseUrl/product/card/'),
        headers: headersUrl,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['order_item'];
    }

    return [];
  }

  Future<void> postCheckOut(int bagTotal) async {
    String? getJwtToken = await getToken();

    Map<String, String> requestHeaders = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $getJwtToken',
    };

    Map<String, dynamic> request = {
      'bagtotal': bagTotal,
    };

    String jsonString = jsonEncode(request);

    final response = await http.post(
        Uri.parse('$baseUrl/product/checkout/'),
        body: jsonString,
    
        headers: requestHeaders,
    );
  }

  Future<void> postProduct(int id, int amount) async {
    String? getJwtToken = await getToken();

    Map<String, String> requestHeaders = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $getJwtToken',
    };
    // Map<String, String> headersUrl = await headersAuthorization();

    Map<String, dynamic> request = {
      'product_id': id,
      'amount': amount
    };

    String jsonString = jsonEncode(request);

    final response = await http.post(
        Uri.parse('$baseUrl/product/add_to_card/'),
        // body: {"product_id": id.toInt(), "amount": amount.toInt()},
        body: jsonString,
    
        headers: requestHeaders,
    );
  }



  Future<Map<String, dynamic>> getProfile() async {
    String? getJwtToken = await getToken();

    Map<String, String> requestHeaders = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $getJwtToken',
    };

    final response = await http.get(
        Uri.parse('$baseUrl/user/profile/'),
    
        headers: requestHeaders,
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    return data;
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
