import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/model/resto.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class DiyoUtill {
  static void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static formatNumber(int number) {
    var f = NumberFormat.decimalPattern("ID");
    return "Rp. ${f.format(number)}";
  }

  static final logger = Logger();
  static final Resto restoPlaceholder = Resto(
      address: "Lorem ipsum dolor",
      name: "Lorem ipsum",
      category: "Lorem",
      image:
          "https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg");

  static Future<Resto?> verifyQRCode(String code) async {
    RestoController restoController = Get.find<RestoController>();
    RegExp regex = RegExp(r'^diyo-\d*[1-9]\d*-\d*[1-9]\d*$');
    if (!regex.hasMatch(code)) {
      return null;
    }
    await restoController.getResto();
    try {
      int id = int.parse(code.split("-")[1]);
      int meja = int.parse(code.split("-")[2]);
      restoController.setMejaActive(meja);
      return restoController.restoList.where((p0) => p0.id == id).first;
    } catch (e) {
      DiyoUtill.logger.e(e);
      return null;
    }
  }

  static Future<bool> menuDetailBagDialog(BuildContext context) async {
    CheckoutController checkoutController = Get.find<CheckoutController>();
    if (checkoutController.listCartItem.isEmpty) {
      return true;
    }
    var confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Apakah anda yakin?",
              style: TextStyle(fontWeight: FontWeight.w900)),
          content: const Text(
              "Bila anda keluar dari halaman ini, semua item yang anda masukan dalam keranjang belanja akan hilang."),
          actions: <Widget>[
            MaterialButton(
              color: DiyoThemeFont.blackFontColor,
              child: Text("Batal",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: DiyoThemeFont.sizeBodyCopy)),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            MaterialButton(
              color: DiyoTheme.diyotheme,
              child: Text("OK",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: DiyoThemeFont.sizeBodyCopy)),
              onPressed: () {
                checkoutController.listCartItem.value = [];
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    return confirm ?? false;
  }
}
