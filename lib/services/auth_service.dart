import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:myqris/models/auth_model.dart';
import 'package:myqris/models/driver_model.dart';
import 'package:myqris/models/profile_model.dart';
import 'package:myqris/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  SharedPreferences? _sharedPrefs;

  Future<AuthModel> login({
    required String email,
    required String name,
    required String fcmToken,
  }) async {
    var url = '$baseUrl/auth/login';
    var code = "}_-2[hZ4#d/Dk{DY7CcXJfdYg,\$J:xEGj_B]]h2R):8h&vd8N(KFC{ASd.)5";
    var headers = {
      'Content-Type': 'application/json',
      'x-bantu-maxim': code.toString(),
    };
    var body = jsonEncode({
      'email': email,
      'name': name,
      'fcm_token': fcmToken,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      AuthModel user = AuthModel.fromJson(data);

      print(data);
      user.token = 'Bearer ' + data['token'];

      _sharedPrefs = await SharedPreferences.getInstance();

      // _sharedPrefs?.setInt('id', user.driver!.id!);
      // _sharedPrefs?.setString('name', user.driver!.name!);
      // _sharedPrefs?.setString('email', user.driver!.email!);
      // _sharedPrefs?.setString('phone', user.driver!.phone ?? '');
      // _sharedPrefs?.setInt('saldo', user.driver!.saldo ?? 0);
      // _sharedPrefs?.setBool('isLogin', true);
      _sharedPrefs?.setString('token', user.token!);
      print(_sharedPrefs?.getString('token'));
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<bool> logout() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/auth/logout';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token.toString(),
    };

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);
    print(token);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Logout');
    }
  }

  Future<ProfileModel> getProfile() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var url = '$baseUrl/auth/me';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // if (response.statusCode == 200) {
    //   var data = jsonDecode(response.body)['data'];
    //   print(data);
    //   ProfileModel main = ProfileModel.fromJson(data);

    //   return main;
    // } else {
    //   throw Exception('Gagal mengambil data ');
    // }

    return ProfileModel.fromJson(jsonDecode(response.body)['data']);
  }
}
