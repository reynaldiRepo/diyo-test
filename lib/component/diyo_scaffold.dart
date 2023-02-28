import 'package:diyo/component/diyo_bottom_bar.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/model/resto.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiyoScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final bool useBottomBar;
  final Function(int idx)? onBottomBarClick;
  final Color? backgroundColor;
  final RestoController restoController = Get.find<RestoController>();

  DiyoScaffold(
      {super.key,
      this.body,
      this.useBottomBar = true,
      this.appBar,
      this.backgroundColor,
      this.onBottomBarClick});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        backgroundColor:
            backgroundColor ?? const Color.fromARGB(255, 244, 242, 242),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: useBottomBar
            ? FloatingActionButton(
                backgroundColor: DiyoTheme.diyotheme,
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                ),
                onPressed: () {
                  restoController.setExpectedViewedresto(Resto());
                  Get.toNamed("/scanner", preventDuplicates: true);
                },
              )
            : null,
        bottomNavigationBar: useBottomBar
            ? DiyoBottomBar(
                key: const Key("BottomBar"),
                onBottomBarClick: (idx) {
                  onBottomBarClick!(idx);
                },
              )
            : null,
        body: body,
      ),
    );
  }
}
