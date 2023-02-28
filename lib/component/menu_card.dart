import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/component/diyo_shimmer.dart';
import 'package:diyo/model/menu.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  final void Function()? onTap;
  const MenuCard({super.key, required this.menu, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                width: 80,
                height: 80,
                child: CachedNetworkImage(
                  imageUrl: menu.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return DiyoShimmer(
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(
                menu.name,
                style: TextStyle(
                    color: DiyoThemeFont.blackFontColor,
                    fontSize: DiyoThemeFont.sizeH3,
                    fontWeight: FontWeight.w900),
              )),
              const SizedBox(width: 12),
              Text(
                DiyoUtill.formatNumber(menu.price),
                style: TextStyle(
                    color: DiyoThemeFont.blackFontColor,
                    fontSize: DiyoThemeFont.sizeH3,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(top: 8),
              height: 1,
              width: double.infinity,
              color: Colors.grey[300])
        ],
      ),
    );
  }
}
