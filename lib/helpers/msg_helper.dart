import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myqris/utils/constants.dart';

class MsgHelper {
  static void msgPeringatan(String promp) {
    Get.snackbar('Peringatan', promp,
        duration: Duration(seconds: 5),
        backgroundColor: yellowColor,
        overlayBlur: 1,
        colorText: Colors.white);
  }

  static void msgError(String promp) {
    Get.snackbar('Error', promp,
        backgroundColor: redColor, overlayBlur: 1, colorText: Colors.white);
  }

  static void msgSuccess(String promp) {
    Get.snackbar('Berhasil', promp,
        backgroundColor: Colors.green, overlayBlur: 1, colorText: Colors.white);
  }

  static void snackErrorTry(VoidCallback onPress, [String? promp]) {
    Get.snackbar('', '',
        duration: Duration(seconds: 5),
        overlayBlur: 1,
        mainButton: TextButton.icon(
            label: Text(
              'Coba lagi',
              style: nunitoTextStyle.copyWith(color: whiteColor),
            ),
            icon: Icon(Icons.refresh, color: whiteColor),
            onPressed: onPress),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.TOP,
        isDismissible: false,
        backgroundColor: redColor,
        barBlur: 40.0,
        titleText: Text(
          'Error',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          promp == null ? 'Internet koneksi gagal' : promp,
          style: nunitoTextStyle.copyWith(color: Colors.white),
        ));
  }
}
