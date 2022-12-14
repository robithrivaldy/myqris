import 'package:flutter/material.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:provider/provider.dart';

class BankSheet extends StatefulWidget {
  BankSheet({Key? key}) : super(key: key);

  @override
  State<BankSheet> createState() => _BankSheetState();
}

class _BankSheetState extends State<BankSheet> {
  @override
  Widget build(BuildContext context) {
    WithdrawProvider withdrawProvider = Provider.of<WithdrawProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  'Pilih Bank',
                  style: nunitoTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 64),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextFormField(
              autocorrect: true,
              style: nunitoTextStyle.copyWith(
                color: blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: ' Cari Bank',
                prefixIcon: const Icon(Icons.search_sharp, size: 26),
                hintStyle: nunitoTextStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffEAEAEA), width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: primaryColor, width: 1),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 128),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: withdrawProvider.bank
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          withdrawProvider.bankCode = e.name!;
                          Navigator.pop(context);
                        },
                        splashColor: greyColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            e.name!,
                            style: nunitoTextStyle.copyWith(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
