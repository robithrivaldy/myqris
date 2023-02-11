import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myqris/api/google_api.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/main.dart';
import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/pages/home_blank.dart';
import 'package:myqris/pages/profile_page.dart';
import 'package:myqris/pages/tab/transactions.dart';
import 'package:myqris/pages/tab/withdraws.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/services/auth_service.dart';
import 'package:myqris/sheets/buat_qr_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_new_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_sheet.dart';
import 'package:myqris/sheets/tarik_saldo_status_sheet.dart';
import 'package:myqris/sheets/verification_sheet.dart';
import 'package:myqris/sheets/waiting_verivication_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/bank_card.dart';
import 'package:myqris/widgets/empty_data.dart';
import 'package:myqris/widgets/transaction_card.dart';
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var showButton = false;
  var showBank = true;
  var showSaldo = true;
  var stringStatus = '';
  var idWithdraw = 0;
  var bodyMessage = '';
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    getdata();

    if (Provider.of<AuthProvider>(context, listen: false).getToken == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                // icon: '@mipmap/ic_launcher',
                // icon: '@mipmap/launcher_icon',
                // color: Colors.yellow,
                playSound: true,
                importance: Importance.high,
              ),
            ),
          );

          if (notification.body == "Akun anda telah terverifikasi!") {
            await Future.delayed(Duration(seconds: 1)).then((value) async {
              await Provider.of<MainProvider>(context, listen: false).getMain();
              await Provider.of<WithdrawProvider>(context, listen: false)
                  .getWithdraw();
            }).then((value) async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            });
          } else if (notification.body == "Maaf akun anda kami tolak!") {
            await Future.delayed(Duration(seconds: 1)).then((value) async {
              await Provider.of<MainProvider>(context, listen: false).getMain();
              await Provider.of<WithdrawProvider>(context, listen: false)
                  .getWithdraw();
            }).then((value) async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            });
          } else {
            List<String> splitted = notification.body!.split(" ");
            idWithdraw = int.parse(splitted[6]).toInt();
            print(int.parse(splitted[6]).toInt());
            await Provider.of<WithdrawProvider>(context, listen: false)
                .getDetailWithdraw(idWithdraw)
                .then((value) {
              getdata();

              showModalBottomSheet<void>(
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
                  builder: (BuildContext context) {
                    return TarikSaldoStatusSheet(
                        Provider.of<WithdrawProvider>(context, listen: false)
                            .withdrawDetail);
                  });
            });
          }
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        Navigator.pushNamed(context, '/');
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {}).cancel();
    _tabController!.dispose();
    super.dispose();
  }

  getdata() async {
    await Provider.of<AuthProvider>(context, listen: false).getSession();

    await Future.delayed(Duration(seconds: 1)).then((value) async {
      await Provider.of<MainProvider>(context, listen: false).getMain();
      await Provider.of<WithdrawProvider>(context, listen: false).getWithdraw();
    });

    // if (Provider.of<MainProvider>(context, listen: false).isLoading == false) {
    //   print(Provider.of<MainProvider>(context, listen: false).isLoading);
    //   showDialogBox();
    // }
    setState(() {});
  }

  void handleShowBank() {
    setState(() {
      showBank = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    MainProvider mainProvider = Provider.of<MainProvider>(context);
    if (mainProvider.isLoading == false) {
      if (mainProvider.main.status == "Requested") {
        stringStatus = "Lengkapi Data Diri";
      }
      if (mainProvider.main.status == "Verifying") {
        stringStatus = "⏳ Menunggu verifikasi 2x 24 jam";
      }

      if (mainProvider.main.status == "Rejected") {
        stringStatus = "⛔️ Ditolak, silahkan verifikasi ulang";
      }
    }

    tarikSaldoHandle() async {
      EasyLoading.show(dismissOnTap: false, status: 'Mohon Tunggu');
      if (mainProvider.main.status == "Activated") {
        await AuthService().getProfile().then((e) async {
          authProvider.profile = e;
          if (e.bankCode == "") {
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
                  return StatefulBuilder(builder: (context, setNewState) {
                    return TarikSaldoNewSheet(authProvider.profile);
                  });
                });
          } else {
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
                  return StatefulBuilder(builder: (context, setNewState) {
                    return TarikSaldoSheet(authProvider.profile);
                  });
                });
          }
        }).catchError((err) {
          MsgHelper.snackErrorTry(() {
            tarikSaldoHandle();
          });
        });
      } else if (mainProvider.main.status == "Verifying") {
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
              return StatefulBuilder(builder: (context, setNewState) {
                return WaitingVerivicationSheet();
              });
            });
      } else {
        showModalBottomSheet<void>(
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
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setNewState) {
                return VerivicationSheet();
              });
            });
      }
      EasyLoading.dismiss();
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: mainProvider.isLoading
            ? LazyAntrian()
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 16,
                    ),
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: primaryColor,
                      onRefresh: () => getdata(),
                      child: ListView(
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage(mainProvider.main),
                                ),
                              );
                            },
                            splashColor: greyColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi, ${mainProvider.main.name ?? ''}',
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
                                  "assets/avatar.png",
                                  height: 56,
                                  width: 56,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          mainProvider.main.status == "Activated"
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    if (mainProvider.main.status !=
                                        "Verifying") {
                                      showModalBottomSheet<void>(
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
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(builder:
                                                (context, setNewState) {
                                              return VerivicationSheet();
                                            });
                                          });
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 14),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF2F2F2),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          stringStatus,
                                          style: nunitoTextStyle.copyWith(
                                            color: blackColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                        mainProvider.main.status == "Verifying"
                                            ? const SizedBox()
                                            : const Icon(
                                                Icons.arrow_right_alt_outlined,
                                                size: 30,
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 22, bottom: 24, left: 24, right: 24),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  height: 8,
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
                                          tarikSaldoHandle();
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
                                                topRight:
                                                    Radius.circular(14.0)),
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
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        mainProvider.main.status == "Activated"
                            ? SizedBox(
                                height: 300,
                              )
                            : SizedBox(
                                height: 360,
                              ),
                        Container(
                          height: 42,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(12)),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            labelColor: blackColor,
                            unselectedLabelColor: blackColor,
                            labelStyle: nunitoTextStyle.copyWith(
                              fontWeight: FontWeight.w800,
                              color: blackColor,
                              fontSize: 14,
                            ),
                            tabs: [
                              Tab(
                                text: 'Transaksi',
                              ),
                              Tab(
                                text: 'Tarik Saldo',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Transactions(),
                              Withdraws(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
