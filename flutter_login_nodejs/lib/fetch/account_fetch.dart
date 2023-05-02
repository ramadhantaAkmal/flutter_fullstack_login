import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/account_model.dart';

class AccountApi {
  static const String url = 'http://10.0.2.2:3000/api';

  static getuser(int userId) async {
    try {
      Uri a = Uri.parse('$url/accounts/$userId');
      final response = await http.get(a);
      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        final body = json.decode(response.body);
        return body;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        final statusCode = response.statusCode;
        return "error status code: $statusCode";
      }
    } catch (e) {
      return "error";
    }
  }

  static userLogin(String username, String password) async {
    try {
      String login = '$url/accounts/login';
      final response = await http.post(
        Uri.parse(login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        final body = json.decode(response.body);
        return body;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        final statusCode = response.statusCode;
        return "error status code: $statusCode";
      }
    } catch (e) {
      return "error";
    }
  }
}
