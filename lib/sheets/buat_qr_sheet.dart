import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myqris/pages/detail_transaction_page.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/providers/transaction_provider.dart';
import 'package:myqris/services/transaction_service.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class BuatQrSheet extends StatefulWidget {
  const BuatQrSheet({Key? key}) : super(key: key);

  @override
  State<BuatQrSheet> createState() => _BuatQrSheetState();
}

class _BuatQrSheetState extends State<BuatQrSheet> {
  bool showButton = true;
  bool alertNominal = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // Provider.of<TransactionProvider>(context, listen: false)
    //     .nominalQrController
    //     .dispose();
    super.dispose();
  }

  Widget boxContainer(i) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    return InkWell(
      onTap: () {
        var string = transactionProvider.nominalQrController.text + i;
        string = transactionProvider.formatNumber(string.replaceAll('.', ''));
        transactionProvider.nominalQrController.value = TextEditingValue(
          text: string,
          selection: TextSelection.collapsed(offset: string.length),
        );
      },
      splashColor: greyColor,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
        width: MediaQuery.of(context).size.width,
        height: 44,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: greyColor.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(1, 3) // changes position of shadow
                ),
          ],
        ),
        child: Text(
          i.toString(),
          style: robotoTextStyle.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget backSpaceContainer() {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    return InkWell(
      onTap: () {
        // String str = transactionProvider.nominalQrController.text;
        // transactionProvider.nominalQrController.text =
        //     str.substring(0, str.length - 1);
        String str = transactionProvider.nominalQrController.text;

        if (str.length == 1) {
          transactionProvider.nominalQrController.text = "";
        } else {
          var string = str.substring(0, str.length - 1);
          string = transactionProvider.formatNumber(string.replaceAll('.', ''));
          transactionProvider.nominalQrController.value = TextEditingValue(
            text: string,
            selection: TextSelection.collapsed(offset: string.length),
          );
        }
      },
      splashColor: greyColor,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
        width: MediaQuery.of(context).size.width,
        height: 44,
        decoration: BoxDecoration(
          color: Color(0xffCBCED5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: greyColor.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(1, 3) // changes position of shadow
                ),
          ],
        ),
        child: Icon(Icons.backspace_outlined),
      ),
    );
  }

  Widget emptyContainer() {
    return InkWell(
      onTap: () {},
      splashColor: greyColor,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
        width: MediaQuery.of(context).size.width,
        height: 44,
        decoration: BoxDecoration(
          color: Color(0xffCBCED5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: greyColor.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(1, 3) // changes position of shadow
                ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    MainProvider mainProvider = Provider.of<MainProvider>(context);

    void buatQRHandle() async {
      var price =
          transactionProvider.nominalQrController.text.replaceAll('.', '');
      var intPrice = int.parse(price).toInt();
      if (intPrice > 999) {
        await transactionProvider.createQr();
      } else if (transactionProvider.nominalQrController.text == "") {
        setState(() {
          alertNominal = true;
        });
      } else {
        setState(() {
          alertNominal = true;
        });
      }
    }

    transactionProvider.nominalQrController.text = '';
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: 24,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Buat QR',
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
                iconSize: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                autocorrect: true,
                showCursor: true,
                readOnly: true,
                keyboardType: TextInputType.number,
                controller: transactionProvider.nominalQrController,
                onChanged: (string) {
                  string = transactionProvider
                      .formatNumber(string.replaceAll(',', ''));
                  transactionProvider.nominalQrController.value =
                      TextEditingValue(
                    text: string,
                    selection: TextSelection.collapsed(offset: string.length),
                  );
                },
                // inputFormatters: [
                //   FilteringTextInputFormatter.digitsOnly,
                //   CurrencyTextInputFormatter(
                //     decimalDigits: 0,
                //     locale: 'id',
                //   )
                // ],
                textInputAction: TextInputAction.done,
                style: nunitoTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  // prefixText: transactionProvider.currency + ' ',
                  // prefixText: 'Rp ',
                  prefixIcon: SizedBox(
                    child: Center(
                      widthFactor: 0.0,
                      child: Text(
                        'Rp',
                        style: nunitoTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  prefixStyle: nunitoTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  isDense: true,
                  hintText: ' Masukkan Nominal',
                  hintStyle: nunitoTextStyle.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  fillColor: whiteColor,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(color: Color(0xffEAEAEA), width: 1.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                ),
              ),
            ),
          ),
          alertNominal
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Minimal Nominal Rp 1.000',
                      style: nunitoTextStyle.copyWith(
                        color: const Color(0xffFF314A),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),

          const SizedBox(
            height: 20,
          ),
          showButton
              ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: boxContainer("1")),
                        Expanded(child: boxContainer("2")),
                        Expanded(child: boxContainer("3")),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: boxContainer("4")),
                        Expanded(child: boxContainer("5")),
                        Expanded(child: boxContainer("6")),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: boxContainer("7")),
                        Expanded(child: boxContainer("8")),
                        Expanded(child: boxContainer("9")),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: emptyContainer()),
                        Expanded(child: boxContainer("0")),
                        Expanded(child: backSpaceContainer()),
                      ],
                    ),
                  ],
                )
              : Container(),

          const SizedBox(height: 16),
          // showButton == true
          Container(
            margin: const EdgeInsets.only(bottom: 24),
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
                buatQRHandle();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              color: blackColor,
              splashColor: greyColor,
              child: Text(
                'Buat QR',
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
}
