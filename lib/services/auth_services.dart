import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyARt55UTWCc5k75tkYreXiIwJafX1kw4A8';
  final storage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final response = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodeResponse = jsonDecode(response.body);

    if (kDebugMode) {
      print(decodeResponse);
    }

    if(decodeResponse.containsKey('idToken')){
      //Guardar token en un lugar seguro
      storage.write(key: 'idToken', value: decodeResponse['idToken']);
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    });

    final response = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodeResponse = jsonDecode(response.body);

    if (kDebugMode) {
      print(decodeResponse);
    }

    if(decodeResponse.containsKey('idToken')){
      //Guardar token en un lugar seguro
      storage.write(key: 'idToken', value: decodeResponse['idToken']);
      return null;
    } else {
      return decodeResponse['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'idToken');

    return;
  }

  Future<String> readToken() async {

    return await storage.read(key: 'idToken') ?? '';

  }

}