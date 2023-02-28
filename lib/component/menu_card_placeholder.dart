import 'package:diyo/component/diyo_shimmer.dart';
import 'package:flutter/material.dart';

class MenuCardPlaceHolder extends StatelessWidget {
  const MenuCardPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DiyoShimmer(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DiyoShimmer(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  width: 80,
                  height: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            DiyoShimmer(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                width: 90,
                height: 16,
              ),
            ),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(top: 8),
            height: 1,
            width: double.infinity,
            color: Colors.grey[300])
      ],
    );
  }
}
