import 'package:diyo/component/msg_data_not_found.dart';
import 'package:diyo/component/resto_card.dart';
import 'package:diyo/component/resto_card_placeholder.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllRestoScreen extends StatelessWidget {
  AllRestoScreen({super.key});
  final RestoController restoController = Get.find<RestoController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: RefreshIndicator(
        onRefresh: () => restoController.getResto(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Semua Restoran",
                style: TextStyle(
                    color: DiyoThemeFont.blackFontColor,
                    fontWeight: FontWeight.w700,
                    fontSize: DiyoThemeFont.sizeH2),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(() => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: !restoController.isLoadResto.value
                        ? restoController.restoList.length
                        : 15,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 12,
                      );
                    },
                    itemBuilder: (context, index) {
                      if (!restoController.isLoadResto.value) {
                        return RestoCard(
                          resto: restoController.restoList[index],
                          onTap: () {
                            restoController.setExpectedViewedresto(
                                restoController.restoList[index]);
                            Get.toNamed("/scanner");
                          },
                        );
                      } else {
                        return const RestoCardPlaceHolder();
                      }
                    },
                  )),
              Obx(
                () {
                  if (restoController.isLoadResto.isFalse &&
                      restoController.restoList.isEmpty) {
                    return const NoDataFoundMSG(
                      msg: "Tidak ada data restoran yang ditemukan",
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
