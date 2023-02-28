import 'package:diyo/controller/navigation_controller.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:get/get.dart';

class DiyoBottomBarIcon {
  final IconData iconData;
  final String title;
  const DiyoBottomBarIcon({required this.iconData, required this.title});
}

class DiyoBottomBar extends StatelessWidget {
  final Function(int idx)? onBottomBarClick;
  DiyoBottomBar({super.key, this.onBottomBarClick});
  final listIcons = <DiyoBottomBarIcon>[
    const DiyoBottomBarIcon(iconData: Icons.home, title: "Restoran"),
    const DiyoBottomBarIcon(iconData: Icons.schedule, title: "Pesanan"),
    const DiyoBottomBarIcon(iconData: Icons.favorite, title: "Favorit"),
    const DiyoBottomBarIcon(iconData: Icons.person, title: "Akun"),
  ];

  final NavigationController navigationController =
      Get.find<NavigationController>();

  Widget tabBuilder(int index, isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          listIcons[index].iconData,
          size: 24,
          color: isActive ? DiyoTheme.diyotheme : const Color(0xFFC6D1D8),
        ),
        Text(
          listIcons[index].title,
          style: const TextStyle(color: Color(0xFFC6D1D8), fontSize: 11),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedBottomNavigationBar.builder(
        activeIndex: navigationController.indexBottomBar.value,
        itemCount: listIcons.length,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        notchMargin: 5,
        tabBuilder: tabBuilder,
        splashSpeedInMilliseconds: 0,
        onTap: (p0) {
          navigationController.setIndexBottomBar(p0);
          onBottomBarClick!(p0);
        },
      ),
    );
  }
}
