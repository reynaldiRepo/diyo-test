import 'package:diyo/component/diyo_scaffold.dart';
import 'package:diyo/component/diyo_app_bar.dart';
import 'package:diyo/controller/navigation_controller.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/screen/account_screen.dart';
import 'package:diyo/screen/all_resto_screen.dart';
import 'package:diyo/screen/favorit_screen.dart';
import 'package:diyo/screen/pesanan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RestoController restoController = Get.find<RestoController>();
  NavigationController navigationController = Get.find<NavigationController>();
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  List<Widget> screens = [
    AllRestoScreen(
      key: const Key("RestoAllScreen"),
    ),
    PesananScreen(key: const Key("PesananScreen")),
    FavoritScreen(key: const Key("FavoritScreen")),
    const AccountScreen(key: Key("AccountScreen"))
  ];

  void handleBottomBarClick(int idx) {
    pageController.jumpToPage(idx);
    navigationController.setIndexBottomBar(idx);
  }

  @override
  Widget build(BuildContext context) {
    return DiyoScaffold(
      onBottomBarClick: handleBottomBarClick,
      appBar: const DiyoAppBar(),
      body: PageView.builder(
          pageSnapping: true,
          allowImplicitScrolling: true,
          onPageChanged: (value) =>
              navigationController.setIndexBottomBar(value),
          itemCount: screens.length,
          controller: pageController,
          itemBuilder: (context, index) => screens[index]),
    );
  }
}
