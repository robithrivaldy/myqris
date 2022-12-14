import 'package:myqris/models/driver_model.dart';

class AuthModel {
  String? token;
  DriverModel? driver;

  AuthModel({this.token, this.driver});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    driver = json['driver'] != null
        ? new DriverModel.fromJson(json['driver'])
        : null;
  }
}
