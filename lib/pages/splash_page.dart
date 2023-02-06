import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myqris/main.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:myqris/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  SharedPreferences? _sharedPrefs;

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    await Future.delayed(Duration(seconds: 2)).then((value) async {
      await Provider.of<AuthProvider>(context, listen: false).getSession();
      _sharedPrefs = await SharedPreferences.getInstance();
      var token = _sharedPrefs?.getString('token');

      if (token == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        await Provider.of<MainProvider>(context, listen: false).getStart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 100,
          ),
        ),
      ),
    );
  }
}
