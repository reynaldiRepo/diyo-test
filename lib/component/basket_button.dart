import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';

class BasketButton extends StatelessWidget {
  final int qty;
  final String text;
  final int total;
  final void Function()? onTap;
  const BasketButton(
      {super.key,
      required this.qty,
      required this.text,
      required this.total,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 4, color: Colors.black45, offset: Offset(0, 2))
              ],
              color: DiyoTheme.diyotheme,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Color.fromARGB(255, 205, 55, 41)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  "$qty",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: DiyoThemeFont.sizeBodyCopy),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Text(text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: DiyoThemeFont.sizeBodyCopy))),
              const SizedBox(
                width: 12,
              ),
              Text(DiyoUtill.formatNumber(total),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: DiyoThemeFont.sizeBodyCopy))
            ],
          ),
        ),
      ),
    );
  }
}
