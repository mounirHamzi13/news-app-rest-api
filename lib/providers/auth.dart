import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static String? userId;
  static late String email;

  Future<bool> signUp(String email, String password) async {
    try {
      // Create the request body
      var requestBody = {
        'email': email,
        'mdp': password,
      };

      // Send the sign-up request to the PHP endpoint
      var response = await http.post(
        Uri.parse('http://192.168.0.189/pfe/user/signupuser.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      

      if (response.statusCode == 201) {
        Auth.userId = jsonDecode(response.body)['user_id'];
        Auth.email = jsonDecode(response.body)['user_email'];
        return true;
      } else if (response.statusCode == 409) {
        // Sign-up failed
        print('email already exist');
        return false;
      } else {
        print('internal server error');
        return false;
      }
    } catch (e) {
      // Error occurred, handle it appropriately
      return false;
    }
  }

  Future<bool> logIn(String email, String password) async {
    print('login in time');
    try {
      var requestBody = {
        'email': email,
        'mdp': password,
      };

      var response = await http.post(
        Uri.parse('http://192.168.0.189/pfe/user/login_mounir.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      ); 


      if (response.statusCode == 404) {
        print('email not found');
        return false;
      } else if (response.statusCode == 200) {
        userId = jsonDecode(response.body)['user_id'];
        return true;
      } else if (response.statusCode == 401) {
        print('incorrect password');
        return false;
      } else {
        return false;
      }
    } catch (e) {
      // return false;
      rethrow;
    }
  }
}
