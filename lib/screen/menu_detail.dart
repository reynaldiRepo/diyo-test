import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/component/basket_button.dart';
import 'package:diyo/component/diyo_scaffold.dart';
import 'package:diyo/component/diyo_shimmer.dart';
import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class MenuDetailHero extends StatelessWidget {
  final String imageURL;
  const MenuDetailHero({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      color: Colors.grey,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
              child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, url) {
              return DiyoShimmer(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              );
            },
            imageUrl: imageURL,
          )),
          Positioned(
            top: 12,
            left: 16,
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: DiyoTheme.diyotheme,
                    borderRadius: BorderRadius.circular(24)),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuDetailInfo extends StatelessWidget {
  final CheckoutController checkoutController = Get.find<CheckoutController>();
  MenuDetailInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  checkoutController.viewedMenu.value.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: DiyoThemeFont.sizeH2,
                      color: DiyoThemeFont.blackFontColor,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                DiyoUtill.formatNumber(
                    checkoutController.viewedMenu.value.price),
                style: TextStyle(
                    fontSize: DiyoThemeFont.sizeH2,
                    color: DiyoThemeFont.blackFontColor,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: DiyoTheme.diyotheme,
          )
        ],
      ),
    );
  }
}

class AddItemSection extends StatefulWidget {
  const AddItemSection({super.key});

  @override
  State<AddItemSection> createState() => _AddItemSectionState();
}

class _AddItemSectionState extends State<AddItemSection> {
  final CheckoutController checkoutController = Get.find<CheckoutController>();
  TextEditingController textEditingController = TextEditingController();
  String request = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var _menu = checkoutController.viewedMenu.value;
      textEditingController.text = checkoutController.getRequestByMenu(_menu);
      setState(() {
        request = checkoutController.getRequestByMenu(_menu);
      });

      textEditingController.addListener(() {
        setState(() {
          request = textEditingController.text;
        });
        checkoutController.updateRequestByMenu(
            _menu, textEditingController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Special Request",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: DiyoThemeFont.blackFontColor),
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: textEditingController,
            maxLength: 255,
            maxLines: 1,
            autofocus: false,
            style: TextStyle(
                fontSize: DiyoThemeFont.sizeH3,
                color: DiyoThemeFont.blackFontColor),
            decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: DiyoThemeFont.sizeH3),
                border: InputBorder.none,
                hintText: "Catatan untuk Restoran"),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  DiyoUtill.unfocus(context);
                  checkoutController.substractListCartItemQTY(
                      checkoutController.viewedMenu.value);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Text("-",
                      style:
                          TextStyle(fontSize: 22, color: DiyoTheme.diyotheme)),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Obx(() {
                var qty = checkoutController.getTotalCartItemQtyByMenu(
                    checkoutController.viewedMenu.value);
                return Text("$qty",
                    style: TextStyle(
                        fontSize: 22, color: DiyoThemeFont.blackFontColor));
              }),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  DiyoUtill.unfocus(context);
                  checkoutController.addListCartItemQTYAndUpdateRequest(
                      checkoutController.viewedMenu.value, request);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Text("+",
                      style:
                          TextStyle(fontSize: 22, color: DiyoTheme.diyotheme)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MenuDetail extends StatefulWidget {
  const MenuDetail({super.key});

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  CheckoutController checkoutController = Get.find<CheckoutController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(
          () => true,
        );
      },
      child: DiyoScaffold(
          useBottomBar: false,
          backgroundColor: Colors.white,
          body: Stack(fit: StackFit.expand, children: [
            Positioned.fill(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              MenuDetailHero(
                                  imageURL: checkoutController
                                      .viewedMenu.value.image),
                              MenuDetailInfo(),
                              const AddItemSection()
                            ])))),
            Obx(() {
              int totalQty = checkoutController.getTotalCartItemQtyByMenu(
                  checkoutController.viewedMenu.value);
              int total = checkoutController
                  .getTotalCartItemByMenu(checkoutController.viewedMenu.value);
              return Positioned(
                  bottom: 0,
                  left: 0,
                  child: totalQty == 0
                      ? const SizedBox.shrink()
                      : BasketButton(
                          onTap: () => Navigator.pop(context),
                          qty: totalQty,
                          text: "Add to Basket",
                          total: total));
            })
          ])),
    );
  }
}
