import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/component/diyo_shimmer.dart';
import 'package:diyo/model/cart_checkout.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PesananCard extends StatelessWidget {
  final CheckoutSummary checkoutSummary;
  const PesananCard({super.key, required this.checkoutSummary});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: CachedNetworkImage(
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => DiyoShimmer(
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.white,
                        ),
                      ),
                  imageUrl: checkoutSummary.resto.image),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(checkoutSummary.resto.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.2,
                                fontSize: DiyoThemeFont.sizeH3,
                                fontWeight: FontWeight.w900,
                                color: DiyoThemeFont.blackFontColor)),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                            "${DiyoUtill.formatNumber(checkoutSummary.getTotalPrice())} (${checkoutSummary.getTotalQty()}x Item)",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.2,
                                fontSize: DiyoThemeFont.sizeBodyCopy,
                                fontWeight: FontWeight.w400,
                                color: DiyoThemeFont.blackFontColor)),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: DiyoThemeFont.blackFontColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                DateFormat("dd/MM/y")
                                    .format(checkoutSummary.time),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: DiyoThemeFont.sizeBodyCopy,
                                    fontWeight: FontWeight.w400,
                                    color: DiyoThemeFont.blackFontColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: const BoxDecoration(
                  color: DiyoTheme.diyotheme,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(8))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 2),
                  Text("Selesai",
                      style: TextStyle(
                          height: 1.2,
                          fontSize: DiyoThemeFont.sizeBodyCopySmall,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                ],
              ))
        ],
      ),
    );
  }
}
