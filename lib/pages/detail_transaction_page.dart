import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myqris/main.dart';
import 'package:myqris/models/transactions_model.dart';
import 'package:myqris/providers/transaction_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailTransactionPage extends StatefulWidget {
  final TransactionsModel data;
  DetailTransactionPage(this.data, {Key? key}) : super(key: key);

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  @override
  void initState() {
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
              icon: '@mipmap/ic_launcher',
              // color: Colors.yellow,
              playSound: true,
              importance: Importance.high,
            ),
          ),
        );

        await Provider.of<TransactionProvider>(context, listen: false)
            .getDetailTransaction(widget.data.id)
            .then((value) async {
          await Future.delayed(Duration(seconds: 1)).then((value) async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailTransactionPage(
                    Provider.of<TransactionProvider>(context, listen: false)
                        .transactionDetail),
              ),
            );
          });
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    final dateTime = DateTime.parse(widget.data.createdAt!);
    final format = DateFormat('dd MMMM yyyy HH:mm');
    var tanggal = format.format(dateTime);

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        elevation: 0.0,
        title: Text(
          'Detail Transaksi',
          style: nunitoTextStyle.copyWith(
            color: black2Color,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: black2Color,
          ),
        ),
      ),
      body: widget.data.status == 'Succeed'
          ? Stack(
              children: [
                Image.asset(
                  'assets/bg_success.png',
                  width: MediaQuery.of(context).size.width,
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      Text(
                        'Pembayaran Sukses 💰',
                        style: nunitoTextStyle.copyWith(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Uang berhasil Succeed',
                        style: nunitoTextStyle.copyWith(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.55),
                    Container(
                      padding: const EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.network(
                                widget.data.paidByLogo!,
                                width: 36,
                                height: 36,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.data.paidBy!,
                                        style: nunitoTextStyle.copyWith(
                                          color: blackColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        tanggal,
                                        style: nunitoTextStyle.copyWith(
                                          color: blackColor.withOpacity(0.4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp ',
                                                decimalDigits: 0)
                                            .format(widget.data.amount!),
                                        style: nunitoTextStyle.copyWith(
                                          color: blackColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE4F6DE),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Text(
                                          'Succeed',
                                          style: nunitoTextStyle.copyWith(
                                            color: greenColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                                  const SizedBox(width: 4),
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
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(widget.data.fee!),
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
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(widget.data.fee! +
                                          widget.data.amount!),
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
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  widget.data.status == 'WaitingPayment'
                      ? Column(
                          children: [
                            HistoryCard(widget.data),
                            const SizedBox(
                              height: 22,
                            ),
                            Text(
                              'Tunjukkan QR ke Customer',
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xffF2F2F2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Expired in 58 : 00 : 11',
                                style: nunitoTextStyle.copyWith(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            QrImage(
                              data: widget.data.qrCode!,
                              version: QrVersions.auto,
                              size: 260.0,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "QR Generate By  ",
                                      style: nunitoTextStyle.copyWith(
                                        color: blackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Product Experience ID ",
                                      style: nunitoTextStyle.copyWith(
                                        color: blackColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Image.asset(
                              'assets/qris_support.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  widget.data.status == 'Cancelled'
                      ? Column(
                          children: [
                            HistoryCard(widget.data),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Transaksi Sudah Dibatalkan',
                              style: nunitoTextStyle.copyWith(
                                color: blackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Pembayaran dibatalkan dan uang tidak diterima',
                              style: nunitoTextStyle.copyWith(
                                color: const Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 300,
                            ),
                          ],
                        )
                      : const SizedBox(),
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
                        ),
                      ),
                      Expanded(
                        child: Text(
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(widget.data.fee!),
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
                          NumberFormat.currency(
                                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(widget.data.fee! + widget.data.amount!),
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
                ],
              ),
            ),
      bottomNavigationBar: widget.data.status == 'WaitingPayment'
          ? Container(
              margin: const EdgeInsets.all(24),
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
                                      'Apa Anda Yakin',
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
                                            'Tidak',
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
                                          onPressed: () async {
                                            await transactionProvider
                                                .cancelTransaction(
                                                    widget.data.id)
                                                .then((value) async {
                                              await transactionProvider
                                                  .getDetailTransaction(
                                                      widget.data.id)
                                                  .then((value) async {
                                                await Future.delayed(
                                                        Duration(seconds: 1))
                                                    .then((value) async {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailTransactionPage(
                                                              transactionProvider
                                                                  .transactionDetail),
                                                    ),
                                                  );
                                                });
                                              });
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          color: blackColor,
                                          splashColor: greyColor,
                                          child: Text(
                                            'Ya saya yakin',
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
            )
          : const SizedBox(),
    );
  }
}
