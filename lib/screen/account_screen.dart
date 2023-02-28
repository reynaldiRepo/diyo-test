import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountMenuItem extends StatelessWidget {
  final String menuTitle;
  const AccountMenuItem({super.key, required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => DiyoUtill.logger.d("Clicked"),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              menuTitle,
              style: TextStyle(
                  fontSize: DiyoThemeFont.sizeBodyCopy,
                  color: DiyoThemeFont.blackFontColor,
                  fontWeight: FontWeight.w900),
            ),
            const Icon(
              Icons.navigate_next,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Account",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AccountMenuItem(menuTitle: "Edit Profile"),
                      AccountMenuItem(menuTitle: "Reset Password"),
                      AccountMenuItem(menuTitle: "Payment Option"),
                      AccountMenuItem(menuTitle: "Notification Option"),
                      AccountMenuItem(menuTitle: "Feedback"),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Other",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      AccountMenuItem(menuTitle: "About Diyo"),
                      AccountMenuItem(menuTitle: "Become Merchant"),
                      AccountMenuItem(menuTitle: "Terms & Conditions"),
                      AccountMenuItem(menuTitle: "Contact Us"),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AccountMenuItem(menuTitle: "Logout"),
                ])));
  }
}
