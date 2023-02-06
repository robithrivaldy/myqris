import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myqris/api/google_api.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/models/auth_model.dart';
import 'package:myqris/models/driver_model.dart';
import 'package:myqris/models/profile_model.dart';
import 'package:myqris/pages/home_page.dart';
import 'package:myqris/pages/login_page.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myqris/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  SharedPreferences? _sharedPrefs;

  static void snackErrorTry(VoidCallback onPress, [String? promp]) {
    Get.snackbar('', '',
        duration: Duration(seconds: 5),
        mainButton: TextButton.icon(
            label: Text(
              'Coba lagi',
              style: GoogleFonts.poppins(color: Colors.green),
            ),
            icon: Icon(Icons.refresh, color: Colors.green),
            onPressed: onPress),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: false,
        backgroundColor: Colors.black87,
        barBlur: 40.0,
        titleText: Text(
          'Error',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          promp == null ? 'Terjadi Kesalahan' : promp,
          style: GoogleFonts.poppins(color: Colors.white),
        ));
  }

  Future<void> getSession() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    print(_sharedPrefs?.getString('token'));
    // print(_sharedPrefs?.getInt('id'));

    // print(_sharedPrefs?.getString('name'));
    // print(_sharedPrefs?.getString('email'));

    // _sharedPrefs!.clear();
  }

  int? get getId => _sharedPrefs?.getInt('id');
  String? get getToken => _sharedPrefs?.getString('token');
  // String? get getName => _sharedPrefs?.getString('name');
  // String? get getEmail => _sharedPrefs?.getString('email');

  // String? get getPhone => _sharedPrefs?.getString('phone');
  // int? get getSaldo => _sharedPrefs?.getInt('saldo');
  AuthModel? _user;
  AuthModel get user => _user!;

  set user(AuthModel user) {
    _user = user;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String name,
  }) async {
    await FirebaseMessaging.instance.getToken().then((value) async {
      print(value);

      AuthModel user = await AuthService()
          .login(email: email, name: name, fcmToken: value.toString());

      _user = user;

      Get.offAll(() => const HomePage());
    });
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
      // EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');

      ProfileModel data = await AuthService().getProfile();
      _profile = data;
      // EasyLoading.dismiss();
    } catch (e) {
      // EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> updateProfileWithImage({
    required String name,
    required String phone,
    required File imageFile,
  }) async {
    _sharedPrefs = await SharedPreferences.getInstance();
    var token = _sharedPrefs?.getString('token');
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(
      '$baseUrl/auth/update-profile',
    );

    var request = http.MultipartRequest(
      "POST",
      uri,
    );
    var multipartFile = http.MultipartFile('id_card_doc_path', stream, length,
        filename: basename(imageFile.path));

    request.headers["authorization"] = '$token';
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['_method'] = 'put';
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);

      // var data = jsonDecode(value)['data'];
      // DriverModel user = DriverModel.fromJson(data);

      // _sharedPrefs?.setString('name', user.name!);
      // _sharedPrefs?.setString('phone', user.phone!);

      // print(_sharedPrefs?.getString('name'));
      // print(_sharedPrefs?.getString('phone'));
    });

    if (response.statusCode == 200) {
    } else {
      throw Exception("Gagal Verivikasi");
    }
  }

  Future<void> logout() async {
    EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');
    await AuthService().logout().then((value) async {
      await GoogleApi.logout();
      _sharedPrefs = await SharedPreferences.getInstance();
      _sharedPrefs!.clear();
      EasyLoading.dismiss();
      Get.offAll(() => LoginPage());
    }).catchError((err) {
      EasyLoading.dismiss();
      MsgHelper.snackErrorTry(() {
        logout();
      });
    });
  }
}
