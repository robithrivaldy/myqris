import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myqris/api/google_api.dart';
import 'package:myqris/main.dart';
import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/pages/profile_page.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/sheets/buat_qr_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/bank_card.dart';
import 'package:myqris/widgets/empty_data.dart';
import 'package:myqris/widgets/history_card.dart';
import 'package:myqris/widgets/lazy_antrian.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var showButton = false;
  var showBank = true;
  var showSaldo = true;

  var bodyMessage = '';
  @override
  void initState() {
    getdata();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      Map<String, dynamic> notif = jsonDecode(notification!.body!);

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notif['message'],
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
              // color: Colors.yellow,
              playSound: true,
              importance: Importance.high,
            ),
          ),
        );

        print(notif['message']);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/');
    });

    super.initState();
  }

  @override
  void dispose() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {}).cancel();
    super.dispose();
  }

  getdata() async {
    await Provider.of<AuthProvider>(context, listen: false).getSession();
    await Provider.of<MainProvider>(context, listen: false).getMain();
  }

  void handleShowBank() {
    setState(() {
      showBank = false;
    });
  }

  Widget tunjukkanQR(context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.88,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: [
            Text(
              'Tunjukkan QR ke Customer',
              style: nunitoTextStyle.copyWith(
                color: blackColor,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Expired in 58 : 00 : 11',
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Image.asset(
              'assets/qr_code.png',
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              'assets/qris_support.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      'Transaction Fee',
                      style: nunitoTextStyle.copyWith(
                        color: const Color(0xff6B7280),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.help_rounded,
                        size: 20,
                        color: const Color(0xffD1D5DB),
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Text(
                    'Rp 512',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      'Total Tagihan',
                      style: nunitoTextStyle.copyWith(
                        color: const Color(0xff6B7280),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Text(
                    'Rp 12.512',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 38,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 24),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE4E4E4), width: 1),
                borderRadius: BorderRadius.circular(14),
              ),
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                onPressed: () {
                  Navigator.pop(context);
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      backgroundColor: const Color(0xffFFFFFF),
                      insetPadding: const EdgeInsets.all(16),
                      child: Stack(
                        overflow: Overflow.visible,
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Apa anda yakin?',
                                      style: nunitoTextStyle.copyWith(
                                        color: black2Color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.only(left: 0),
                                      splashColor: greyColor,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close),
                                      color: black2Color,
                                      iconSize: 30,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                              color: const Color(0xffE4E4E4),
                                              width: 1),
                                        ),

                                        // ignore: deprecated_member_use
                                        child: RaisedButton(
                                          elevation: 0,
                                          hoverElevation: 0,
                                          focusElevation: 0,
                                          highlightElevation: 0,
                                          onPressed: () async {},
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          color: whiteColor,
                                          splashColor: greyColor,
                                          child: Text(
                                            'Batalkan',
                                            style: nunitoTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 56,
                                        decoration: const BoxDecoration(),
                                        // ignore: deprecated_member_use
                                        child: RaisedButton(
                                          elevation: 0,
                                          hoverElevation: 0,
                                          focusElevation: 0,
                                          highlightElevation: 0,
                                          onPressed: () async {},
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          color: blackColor,
                                          splashColor: greyColor,
                                          child: Text(
                                            'Ya yakin',
                                            style: nunitoTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: whiteColor,
                splashColor: greyColor,
                child: Text(
                  'Batalkan Transaksi',
                  style: nunitoTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    lengkapiDataDiri() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.84,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lengkapi data diri',
                  style: nunitoTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.only(left: 0),
                  splashColor: greyColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: blackColor,
                  iconSize: 40,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  isDense: true,
                  hintText: ' Masukkan Nama Lengkap',
                  hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
                  fillColor: whiteColor,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color(0xffEAEAEA), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                autocorrect: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  isDense: true,
                  hintText: ' No HP',
                  hintStyle: nunitoTextStyle.copyWith(color: Colors.grey),
                  fillColor: whiteColor,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color(0xffEAEAEA), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
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
              child: Image.asset('assets/ktp_area.png'),
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
                  size: 14,
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
                              color: Color(0xff545454)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
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
                onPressed: () async {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: blackColor,
                splashColor: greyColor,
                child: Text(
                  'Submit',
                  style: nunitoTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: !(mainProvider.isLoading)
          ? RefreshIndicator(
              backgroundColor: Colors.white,
              color: primaryColor,
              onRefresh: () async => await mainProvider.getMain(),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.pushNamed(context, "/profile");
                        },
                        splashColor: greyColor,
                        child: Row(
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
                                  'Welcome back to MyRQIS',
                                  style: nunitoTextStyle.copyWith(
                                    color: blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/avatar.png",
                              height: 56,
                              width: 56,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              // borderRadius: BorderRadius.circular(14),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) =>
                                lengkapiDataDiri()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lengkapi data diri',
                                style: nunitoTextStyle.copyWith(
                                  color: blackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_right_alt_outlined,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 24),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/bg_saldo.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Saldo Anda',
                                  style: nunitoTextStyle.copyWith(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                showSaldo == true
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showSaldo = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.visibility_outlined,
                                          size: 30,
                                          color: whiteColor,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showSaldo = true;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.visibility_off_outlined,
                                          size: 30,
                                          color: whiteColor,
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            showSaldo == true
                                ? Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(mainProvider.main.saldo!),
                                    style: nunitoTextStyle.copyWith(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24,
                                    ),
                                  )
                                : Text(
                                    '***********',
                                    style: nunitoTextStyle.copyWith(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24,
                                    ),
                                  ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      await authProvider.getProfile().then((e) {
                                        showModalBottomSheet<void>(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(14),
                                                topRight: Radius.circular(14),
                                              ),
                                            ),
                                            backgroundColor: Colors.white,
                                            builder: (BuildContext context) {
                                              return TarikSaldoSheet();
                                            });
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.save_alt,
                                          size: 24,
                                          color: whiteColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Tarik Saldo',
                                          style: nunitoTextStyle.copyWith(
                                            color: whiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    splashColor: greyColor,
                                    onTap: () => showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(14.0),
                                            topRight: Radius.circular(14.0)),
                                      ),
                                      builder: (BuildContext context) {
                                        return BuatQrSheet();
                                      },
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.qr_code,
                                          size: 24,
                                          color: whiteColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Buat QR',
                                          style: nunitoTextStyle.copyWith(
                                            color: whiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Riwayat Transaksi',
                        style: nunitoTextStyle.copyWith(
                          color: blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Column(
                      //   children: mainProvider.main.transactions!
                      //       .map(
                      //         (e) => HistoryCard(e),
                      //       )
                      //       .toList(),
                      // ),
                      mainProvider.main.transactions != []
                          ? Column(
                              children: mainProvider.main.transactions!
                                  .map(
                                    (e) => HistoryCard(e),
                                  )
                                  .toList(),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: SvgPicture.asset("assets/empty.svg"),
                              ),
                            ),
                      mainProvider.main.transactions!.length < 5
                          ? const SizedBox(
                              height: 100,
                            )
                          : const SizedBox(
                              height: 60,
                            )
                    ],
                  ),
                ),
              ),
            )
          : LazyAntrian(),
    );
  }
}
