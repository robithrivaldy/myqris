import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myqris/helpers/msg_helper.dart';
import 'package:myqris/main.dart';
import 'package:myqris/pages/home_page.dart';
import 'package:myqris/providers/auth_provider.dart';
import 'package:myqris/providers/main_provider.dart';
import 'package:myqris/providers/withdraw_provider.dart';
import 'package:myqris/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class VerivicationSheet extends StatefulWidget {
  const VerivicationSheet({Key? key}) : super(key: key);

  @override
  State<VerivicationSheet> createState() => _VerivicationSheetState();
}

class _VerivicationSheetState extends State<VerivicationSheet> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future takePhoto(ImageSource source) async {
    final image = await picker.getImage(
      source: source,
    );
    if (image == null) return;
    final imageTemporary = File(image.path);

    setState(() {
      imageFile = imageTemporary;
    });
  }

  Widget imageView() {
    if (imageFile == null) {
      return Image.asset('assets/ktp_area.png');
    } else {
      return Transform.rotate(
        angle: -90 * math.pi / 180,
        child: Image.file(
          imageFile!,
          height: 200,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleUpdate() async {
      if (nameController.text == "" ||
          phoneController.text == "" ||
          imageFile == null) {
        MsgHelper.msgPeringatan("Masih ada yang kosong, silakan coba lagi");
      } else {
        EasyLoading.show(dismissOnTap: false);
        await authProvider
            .updateProfileWithImage(
                name: nameController.text,
                phone: phoneController.text,
                imageFile: imageFile!)
            .then((value) {
          EasyLoading.dismiss();
          Get.offAll(() => HomePage());
          setState(() {});
        }).catchError((err) {
          EasyLoading.dismiss();
          MsgHelper.snackErrorTry(() {
            handleUpdate();
          });
        });
      }
    }

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
      child: SingleChildScrollView(
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
                controller: nameController,
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
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                controller: phoneController,
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
            Center(
              child: GestureDetector(
                onTap: () => takePhoto(ImageSource.camera),
                child: imageView(),
              ),
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
                onPressed: () async {
                  handleUpdate();
                },
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
      ),
    );
  }
}
