import 'package:myqris/pages/login_page.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        elevation: 0.0,
        title: Text(
          'Profile',
          style: nunitoTextStyle.copyWith(
            color: black2Color,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: black2Color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${authProvider.getName}',
                      style: nunitoTextStyle.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Welcome back to MyQris',
                      style: nunitoTextStyle.copyWith(
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/avatar.png',
                  width: 56,
                  height: 56,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF1F1F5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextFormField(
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                initialValue: "${authProvider.getName}",
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  isDense: true,
                  hintText: ' Masukkan Nama Lengkap',
                  hintStyle: nunitoTextStyle.copyWith(
                    color: Colors.grey,
                  ),
                  fillColor: whiteColor,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF1F1F5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextFormField(
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                initialValue: "${authProvider.getEmail}",
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  isDense: true,
                  hintText: ' Email',
                  hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
                  fillColor: whiteColor,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF1F1F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                autocorrect: true,
                readOnly: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                initialValue: "${authProvider.getPhone}",
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  isDense: true,
                  hintText: ' No HP',
                  hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
                  fillColor: whiteColor,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Color(0xffE1E1E1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: primaryColor, width: 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Upload identitas diri',
              style: nunitoTextStyle.copyWith(
                color: blackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset('assets/ktp.png'),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.lock,
                  color: greyColor,
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              "Kamu diwajibkan untuk verifikasi KTP, untuk mencegah orang lain menggunakan akunmu",
                          style: nunitoTextStyle.copyWith(
                              fontSize: 14, color: Color(0xff545454)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await authProvider.logout().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false));
              },
              splashColor: greyColor,
              child: Center(
                child: Text(
                  'Logout',
                  style: nunitoTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xffFF314A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
