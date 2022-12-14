import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/sheets/bank_sheet.dart';
import 'package:myqris/utils/constants.dart';
import 'package:myqris/widgets/bank_card.dart';
import 'package:provider/provider.dart';

class TarikSaldoSheet extends StatefulWidget {
  TarikSaldoSheet({Key? key}) : super(key: key);

  @override
  State<TarikSaldoSheet> createState() => _TarikSaldoSheetState();
}

class _TarikSaldoSheetState extends State<TarikSaldoSheet> {
  var showButton = false;
  var showBank = true;
  var showSaldo = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<WithdrawProvider>(context, listen: false).getBank();
  }

  void handleShowBank() {
    setState(() {
      showBank = false;
    });
  }

  Widget tarikSaldoYakin(context) {
    WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Apa anda yakin?',
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
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Saldo anda akan diproses untuk dikirim ke akun rekening anda dibawah ini',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff545454),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Bank',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    withdrawProvider.bankCode,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nomor Rekening',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    withdrawProvider.accountNumberController.text,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nama Pemilik',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    withdrawProvider.accountHolderController.text,
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: const Color(0xffE4E4E4), width: 1),
                    ),

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
                      onPressed: () async {
                        // Navigator.pop(context);
                        await withdrawProvider
                            .requestWithdraw()
                            .then((value) => Navigator.pop(context));
                        // showModalBottomSheet<void>(
                        //     isScrollControlled: true,
                        //     context: context,
                        //     barrierColor: Colors.black.withOpacity(0.5),
                        //     shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(14.0),
                        //           topRight: Radius.circular(14.0)),
                        //     ),
                        //     builder: (BuildContext context) {
                        //       return saldoSedang(context);
                        //     });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
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
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget saldoSedang(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '⌛️ Saldo Sedang Dikirim',
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
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Saldo anda sedang diproses untuk dikirim ke akun rekening anda, Silahkan menunggu 1x24 jam.',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff545454),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Bank',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'BCA',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nomor Rekening',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '11294940303',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nama Pemilik',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Jalu Detya Wibawa',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Total Penarikan',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Rp 1.000.000',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
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
                onPressed: () => showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.5),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14.0),
                          topRight: Radius.circular(14.0)),
                    ),
                    builder: (BuildContext context) {
                      return saldoBerhasil(context);
                    }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: blackColor,
                splashColor: greyColor,
                child: Text(
                  'Okey',
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
      ),
    );
  }

  Widget saldoBerhasil(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saldo Berhasil Dikirim 💰🥳',
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
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Saldo berhasil dikirim🥳, Silahkan cek saldo pada rekening anda.",
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff545454),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Bank',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'BCA',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nomor Rekening',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '11294940303',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Nama Pemilik',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Jalu Detya Wibawa',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Total Penarikan',
                    style: nunitoTextStyle.copyWith(
                      color: const Color(0xff6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Rp 1.000.000',
                    style: nunitoTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
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
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: blackColor,
                splashColor: greyColor,
                child: Text(
                  'Okey',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context);
    if (authProvider.profile.bankCode == "") {
      showBank = false;
    } else {
      withdrawProvider.bankCode = authProvider.profile.bankCode!;
      withdrawProvider.accountHolderController.text =
          authProvider.profile.beneficiaryAccountHolder!;
      withdrawProvider.accountNumberController.text =
          authProvider.profile.beneficiaryAccountNumber!;
      showBank = true;
    }

    if (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) {
      showButton = false;
    } else {
      showButton = true;
    }

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
                '💰Tarik Saldo',
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(authProvider.profile.saldo!),
                  style: nunitoTextStyle.copyWith(
                    color: whiteColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          showBank == true
              ? Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      BankCard(
                        id: 1,
                        bank: authProvider.profile.bankCode!,
                        image: "assets/bca.png",
                        name: authProvider.profile.beneficiaryAccountHolder!,
                        no: authProvider.profile.beneficiaryAccountNumber!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 38),
                      //   width: double.infinity,
                      //   height: 46,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(14),
                      //     border: Border.all(
                      //         color: const Color(0xff94959B), width: 1),
                      //   ),
                      //   // ignore: deprecated_member_use
                      //   child: RaisedButton(
                      //     elevation: 0,
                      //     hoverElevation: 0,
                      //     focusElevation: 0,
                      //     highlightElevation: 0,
                      //     onPressed: () {
                      //       handleShowBank();
                      //       setState(() {
                      //         showBank = false;
                      //       });
                      //     },
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(14),
                      //     ),
                      //     color: whiteColor,
                      //     splashColor: greyColor,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         const Icon(Icons.add),
                      //         const SizedBox(
                      //           width: 10,
                      //         ),
                      //         Text(
                      //           'Tambah Bank',
                      //           style: nunitoTextStyle.copyWith(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w600,
                      //             color: greyColor,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          autocorrect: true,
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          style: nunitoTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          onTap: () => showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.5),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14.0),
                                  topRight: Radius.circular(14.0)),
                            ),
                            builder: (BuildContext context) {
                              return BankSheet();
                            },
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            isDense: true,
                            hintText: withdrawProvider.bankCode,
                            hintStyle: nunitoTextStyle.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            fillColor: whiteColor,
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color(0xffEAEAEA), width: 1.5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.5),
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
                          keyboardType: TextInputType.number,
                          controller: withdrawProvider.accountNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textInputAction: TextInputAction.done,
                          style: nunitoTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            isDense: true,
                            hintText: ' No Rekening (Pastikan Benar)',
                            hintStyle: nunitoTextStyle.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            fillColor: whiteColor,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color(0xffEAEAEA), width: 1.5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.5),
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
                          controller: withdrawProvider.accountHolderController,
                          textInputAction: TextInputAction.done,
                          style: nunitoTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 16),
                            isDense: true,
                            hintText: ' Nama Rekening (Pastikan Benar)',
                            hintStyle: nunitoTextStyle.copyWith(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            fillColor: whiteColor,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color(0xffEAEAEA), width: 1.5),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 16,
          ),
          showButton == true
              ? Container(
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
                    onPressed: () {
                      Navigator.pop(context);
                      showModalBottomSheet<void>(
                        // isScrollControlled: true,
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.5),

                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14.0),
                              topRight: Radius.circular(14.0)),
                        ),
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                              builder: (context, setNewState) {
                            return tarikSaldoYakin(context);
                          });
                        },
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    color: blackColor,
                    splashColor: greyColor,
                    child: Text(
                      'Tarik Saldo',
                      style: nunitoTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: whiteColor,
                      ),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
