import 'package:myqris/api/google_api.dart';
import 'package:myqris/pages/home_page.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences? _sharedPrefs;
  GoogleSignInAccount? _currentUser;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
                                text: "Syarat dan Ketentuan ",
                                style: nunitoTextStyle.copyWith(
                                    color: blueColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: "dan",
                                style:
                                    nunitoTextStyle.copyWith(color: greyColor),
                              ),
                              TextSpan(
                                text: "Kebijakan Privasi ",
                                style: nunitoTextStyle.copyWith(
                                    color: blueColor,
                                    fontWeight: FontWeight.w400),
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
                    EasyLoading.show(
                        dismissOnTap: false, status: 'Mohon Tunggu');
                    try {
                      var google = await GoogleApi.login();

                      await authProvider
                          .login(
                              email: google!.email, name: google.displayName!)
                          .then((value) => Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false));
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: redColor,
                          content: const Text(
                            'Gagal Masuk, Mohon Ulangi kembali!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    EasyLoading.dismiss();

                    // try {
                    // GoogleSignInAccount? user = await GoogleApi.login();

                    // GoogleSignInAuthentication googleSignInAuthentication =
                    //     await user!.authentication;

                    // print(googleSignInAuthentication.accessToken);

                    //   GoogleSignInAccount? user = await GoogleApi.logout();
                    //   GoogleSignInAuthentication googleSignInAuthentication =
                    //       await user!.authentication;
                    //   print(googleSignInAuthentication.accessToken);

                    //   authProvider.login(email: googleSignInAuthentication., name: name)
                    // } catch (error) {
                    //   print(error);
                    // }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(),
                    //   ),
                    // );
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
