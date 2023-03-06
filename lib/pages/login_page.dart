import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:myqris/api/google_api.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/pages/home_page.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // SharedPreferences? _sharedPrefs;
  // GoogleSignInAccount? _currentUser;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    super.initState();
  }

  // getdata() async {
  //   await Provider.of<AuthProvider>(context, listen: false).getSession();

  //   await Future.delayed(Duration(seconds: 1)).then((value) async {
  //     await Provider.of<MainProvider>(context, listen: false).getMain();
  //     await Provider.of<WithdrawProvider>(context, listen: false).getWithdraw();
  //   });
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    loginHandle() async {
      EasyLoading.show(dismissOnTap: false);

      await GoogleApi.login().then((value) async {
        await authProvider.login(email: value!.email, name: value.displayName!);
        EasyLoading.dismiss();
      }).catchError((err) {
        print(err);
        EasyLoading.dismiss();
      });
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Permudah terima pembayaran dengan My QRIS',
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '1 QR untuk menerima semua pembayaran',
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Image.asset(
                  'assets/login_image.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lock,
                        color: greyColor,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "Dengan menekan tombol login maka kamu setuju  dengan",
                                style:
                                    nunitoTextStyle.copyWith(color: greyColor),
                              ),
                              TextSpan(
                                text: " Syarat dan Ketentuan ",
                                style: nunitoTextStyle.copyWith(
                                  color: blueColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://cooing-moat-59d.notion.site/Terms-Conditions-317aeb029981494c9acb0e7c99c69983');
                                  },
                              ),
                              TextSpan(
                                text: "dan",
                                style:
                                    nunitoTextStyle.copyWith(color: greyColor),
                              ),
                              TextSpan(
                                text: " Kebijakan Privasi ",
                                style: nunitoTextStyle.copyWith(
                                  color: blueColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(
                                        'https://www.privacypolicies.com/live/61bf44ac-e799-49bb-99ca-c8969c663b05');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,

                height: 56,
                decoration: const BoxDecoration(),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  elevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  onPressed: () async {
                    loginHandle();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  color: Color(0xffF1F1F5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google_icon.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login via Gmail',
                        style: nunitoTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
