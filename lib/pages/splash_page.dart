import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myqris/main.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
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
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null && !kIsWeb) {
    //     flutterLocalNotificationsPlugin!.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel!.id,
    //           channel!.name,
    //           // TODO add a proper drawable resource to android, for now using
    //           //      one that already exists in example app.
    //           icon: '@mipmap/ic_launcher',
    //           // color: Colors.yellow,
    //           playSound: true,
    //           importance: Importance.high,
    //         ),
    //       ),
    //     );
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   Navigator.pushNamed(context, '/');
    // });

    // // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // //   print('A new onMessageOpenedApp event was published!');
    // //   Navigator.pushNamed(context, '/home');
    // // });

    getInit();
    super.initState();
  }

  getInit() async {
    // await Provider.of<MainProvider>(context, listen: false).getSession();

    await Future.delayed(Duration(seconds: 2)).then((value) async {
      // await Provider.of<AuthProvider>(context, listen: false).logout();

      await Provider.of<AuthProvider>(context, listen: false).getSession();
      _sharedPrefs = await SharedPreferences.getInstance();
      var token = _sharedPrefs?.getString('token');
      if (token == null) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        await Provider.of<MainProvider>(context, listen: false).getMain();
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
