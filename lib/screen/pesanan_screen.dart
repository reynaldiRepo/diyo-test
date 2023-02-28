import 'package:diyo/component/msg_data_not_found.dart';
import 'package:diyo/component/pesanan_card.dart';
import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PesananScreen extends StatelessWidget {
  PesananScreen({super.key});

  final CheckoutController checkoutController = Get.find<CheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Pesanan Saya",
                    style: TextStyle(
                        color: DiyoThemeFont.blackFontColor,
                        fontWeight: FontWeight.w700,
                        fontSize: DiyoThemeFont.sizeH2),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () {
                      if (checkoutController.listCheckOut.isEmpty) {
                        return const NoDataFoundMSG(
                            msg: "Tidak ada data pesanan yang ditemukan");
                      } else {
                        return ListView.separated(
                          itemCount: checkoutController.listCheckOut.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          itemBuilder: (context, index) {
                            return PesananCard(
                                checkoutSummary:
                                    checkoutController.listCheckOut[index]);
                          },
                        );
                      }
                    },
                  )
                ])));
  }
}
