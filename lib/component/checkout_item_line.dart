import 'package:diyo/model/cart_checkout.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';

class CheckOutItemLine extends StatelessWidget {
  final CartItem cartItem;
  final void Function()? onDeleteButtonClicked;
  const CheckOutItemLine(
      {super.key, required this.cartItem, this.onDeleteButtonClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minWidth: 35),
            decoration: const BoxDecoration(
                color: DiyoTheme.diyotheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
              "${cartItem.qty}x",
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.menu.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: DiyoThemeFont.blackFontColor,
                    fontSize: DiyoThemeFont.sizeH3,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                cartItem.request == "" ? "-" : cartItem.request,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: DiyoThemeFont.blackFontColor,
                    fontSize: DiyoThemeFont.sizeBodyCopy,
                    fontWeight: FontWeight.w400),
              )
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DiyoUtill.formatNumber(cartItem.qty * cartItem.menu.price),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: DiyoThemeFont.blackFontColor,
                    fontSize: DiyoThemeFont.sizeBodyCopy,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: onDeleteButtonClicked,
                child: Container(
                  width: 19,
                  height: 19,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(19)),
                      border: Border.all(color: DiyoTheme.diyotheme)),
                  child: const Icon(
                    Icons.close_outlined,
                    color: DiyoTheme.diyotheme,
                    size: 16,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
