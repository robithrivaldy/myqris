import 'package:myqris/models/main_model.dart';
import 'package:myqris/pages/login_page.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ProfilePage extends StatefulWidget {
  final MainModel data;
  ProfilePage(this.data, {Key? key}) : super(key: key);

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
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
                        'Hi, ${widget.data.name}',
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
                        'Yuk mulai transaksimu dengan My QRIS ',
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
                  initialValue: "${widget.data.name}",
                  style: nunitoTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    isDense: true,
                    hintText: ' Masukkan Nama Lengkap',
                    hintStyle: nunitoTextStyle.copyWith(
                      color: Colors.grey,
                    ),
                    fillColor: whiteColor,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(color: Color(0xffE1E1E1), width: 1),
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
                  initialValue: "${widget.data.email}",
                  style: nunitoTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    isDense: true,
                    hintText: ' Email',
                    hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
                    fillColor: whiteColor,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(color: Color(0xffE1E1E1), width: 1),
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
                  initialValue: "${widget.data.phone}",
                  style: nunitoTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    isDense: true,
                    hintText: ' No HP',
                    hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
                    fillColor: whiteColor,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(color: Color(0xffE1E1E1), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                      borderSide: BorderSide(color: primaryColor, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () async {
            await authProvider.logout();
          },
          splashColor: greyColor,
          child: Container(
            width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
