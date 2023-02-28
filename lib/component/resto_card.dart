import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/component/diyo_shimmer.dart';
import 'package:diyo/model/resto.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:flutter/material.dart';

class RestoCard extends StatelessWidget {
  final Resto resto;
  final void Function()? onTap;
  const RestoCard({super.key, required this.resto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    imageUrl: resto.image),
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
                          Text(resto.name,
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
                          Text(resto.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  height: 1.2,
                                  fontSize: DiyoThemeFont.sizeBodyCopy,
                                  fontWeight: FontWeight.w400,
                                  color: DiyoThemeFont.blackFontColor)),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(resto.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  height: 1.2,
                                  fontSize: DiyoThemeFont.sizeBodyCopy,
                                  fontWeight: FontWeight.w900,
                                  color: DiyoThemeFont.blackFontColor))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("-",
                              style: TextStyle(
                                  height: 1.2,
                                  fontSize: DiyoThemeFont.sizeBodyCopy,
                                  fontWeight: FontWeight.w400,
                                  color: DiyoThemeFont.blackFontColor)),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("1.2 Km",
                              style: TextStyle(
                                  height: 1.2,
                                  fontSize: DiyoThemeFont.sizeBodyCopySmall,
                                  fontWeight: FontWeight.w900,
                                  color: DiyoTheme.diyotheme)),
                        ],
                      ),
                    )
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
                  color: Color(0xffEBEBEB),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(8))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Color(0xff959AA0),
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Text("5 menit",
                      style: TextStyle(
                          height: 1.2,
                          fontSize: DiyoThemeFont.sizeBodyCopySmall,
                          fontWeight: FontWeight.w900,
                          color: DiyoThemeFont.blackFontColor)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
