import 'package:diyo/util/theme_font.dart';
import 'package:flutter/material.dart';

class NoDataFoundMSG extends StatelessWidget {
  final String msg;
  const NoDataFoundMSG({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Text(msg,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: DiyoThemeFont.sizeH3,
            color: DiyoThemeFont.blackFontColor));
  }
}
