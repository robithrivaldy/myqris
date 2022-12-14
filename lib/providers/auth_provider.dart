import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:myqris/api/google_api.dart';
import 'package:myqris/models/auth_model.dart';
import 'package:myqris/models/profile_model.dart';
import 'package:myqris/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  SharedPreferences? _sharedPrefs;

  Future<void> getSession() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    print(_sharedPrefs?.getInt('id'));
    print(_sharedPrefs?.getString('name'));
    print(_sharedPrefs?.getString('email'));
    print(_sharedPrefs?.getString('token'));

    // _sharedPrefs!.clear();
  }

  int? get getId => _sharedPrefs?.getInt('id');
  String? get getName => _sharedPrefs?.getString('name');
  String? get getEmail => _sharedPrefs?.getString('email');
  String? get getToken => _sharedPrefs?.getString('token');
  String? get getPhone => _sharedPrefs?.getString('phone');
  int? get getSaldo => _sharedPrefs?.getInt('saldo');
  AuthModel? _user;
  AuthModel get user => _user!;

  set user(AuthModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({
    required String email,
    required String name,
  }) async {
    try {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');
      await Firebase.initializeApp();
      FirebaseMessaging.instance.getToken().then((value) async {
        print(value);

        AuthModel user = await AuthService()
            .login(email: email, name: name, fcmToken: value.toString());

        _user = user;
      });

      EasyLoading.dismiss();

      return true;
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');
      await AuthService().logout();
      await GoogleApi.logout().then((value) async {
        _sharedPrefs = await SharedPreferences.getInstance();
        _sharedPrefs!.clear();
      });

      EasyLoading.dismiss();
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
      return false;
    }
  }

  // PROFILE

  ProfileModel? _profile;
  ProfileModel get profile => _profile!;

  set profile(ProfileModel user) {
    _profile = user;
    notifyListeners();
  }

  Future<void> getProfile() async {
    try {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');

      ProfileModel data = await AuthService().getProfile();
      _profile = data;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}
