import 'package:diyo/component/msg_data_not_found.dart';
import 'package:diyo/component/resto_card.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritScreen extends StatelessWidget {
  FavoritScreen({super.key});
  final RestoController restoController = Get.find<RestoController>();

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
                    "Restoran Favorit",
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
                      if (restoController.favoritList.isEmpty) {
                        return const NoDataFoundMSG(
                            msg: "Tidak ada data restoran favorit");
                      } else {
                        return ListView.separated(
                          itemCount: restoController.favoritList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          itemBuilder: (context, index) {
                            return RestoCard(
                              resto: restoController.favoritList[index],
                              onTap: () {
                                restoController.setExpectedViewedresto(
                                    restoController.favoritList[index]);
                                Get.toNamed("/scanner");
                              },
                            );
                          },
                        );
                      }
                    },
                  )
                ])));
  }
}
