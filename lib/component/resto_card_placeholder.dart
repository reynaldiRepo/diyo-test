import 'package:diyo/component/diyo_shimmer.dart';
import 'package:flutter/material.dart';

class RestoCardPlaceHolder extends StatelessWidget {
  const RestoCardPlaceHolder({super.key});

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
                child: DiyoShimmer(
                  child: Container(
                    color: Colors.grey,
                    width: 80,
                    height: 80,
                  ),
                )),
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
                    child: DiyoShimmer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: 70,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          DiyoShimmer(
            child: Container(
              width: 50,
              height: 20,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: const BoxDecoration(
                  color: Color(0xffEBEBEB),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(8))),
            ),
          )
        ],
      ),
    );
  }
}
