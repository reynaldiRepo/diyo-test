import 'package:diyo/component/basket_button.dart';
import 'package:diyo/component/checkout_item_line.dart';
import 'package:diyo/component/diyo_app_bar.dart';
import 'package:diyo/component/diyo_scaffold.dart';
import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/model/cart_checkout.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HeaderCheckout extends StatelessWidget {
  const HeaderCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "Pesananaku",
            maxLines: 1,
            style: TextStyle(
                fontSize: DiyoThemeFont.sizeH2,
                color: DiyoThemeFont.blackFontColor,
                fontWeight: FontWeight.w900),
          ),
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color: const Color.fromARGB(255, 211, 211, 211))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: DiyoTheme.diyotheme),
                  child: const Icon(
                    Icons.restaurant_menu_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "Add Menu",
                  style: TextStyle(
                      fontSize: DiyoThemeFont.sizeBodyCopy,
                      color: DiyoTheme.diyotheme,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CheckoutController checkoutController = Get.find<CheckoutController>();
  RestoController restoController = Get.find<RestoController>();

  void checkOutHandle() {
    CheckoutSummary checkoutSummary = CheckoutSummary(
        time: DateTime.now(),
        cartItem: checkoutController.listCartItem.toList(),
        resto: restoController.viewedResto.value,
        mejaCode:
            "diyo-${restoController.viewedResto.value.id}-${restoController.mejaActive.value}");
    checkoutController.addCheckOutSummary(checkoutSummary);
    checkoutController.clearCartItem();
    Fluttertoast.showToast(msg: "Checkout Success");
    Get.offAllNamed("/", predicate: (route) => Get.currentRoute == "/");
  }

  @override
  Widget build(BuildContext context) {
    return DiyoScaffold(
        appBar: DiyoAppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
            title:
                "Pesanan (Meja-diyo-${restoController.viewedResto.value.id}-${restoController.mejaActive.value})"),
        useBottomBar: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const HeaderCheckout(),
                        const SizedBox(
                          height: 24,
                        ),
                        Obx(() => ListView.separated(
                              itemCount: checkoutController.listCartItem.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) {
                                var cartItem =
                                    checkoutController.listCartItem[index];
                                return CheckOutItemLine(
                                  cartItem: cartItem,
                                  onDeleteButtonClicked: () {
                                    checkoutController.deleteCartItem(cartItem);
                                    if (checkoutController
                                        .listCartItem.isEmpty) {
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Subtotal",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: DiyoThemeFont.sizeBodyCopy,
                                    color: DiyoThemeFont.blackFontColor)),
                            Obx(() => Text(
                                DiyoUtill.formatNumber(
                                    checkoutController.getTotalCartItem()),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: DiyoThemeFont.sizeBodyCopy,
                                    color: DiyoThemeFont.blackFontColor)))
                          ],
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Container(
                          width: double.infinity,
                          height: 8,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Kode Promo",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: DiyoThemeFont.sizeBodyCopy,
                                    color: DiyoThemeFont.blackFontColor)),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.grey[300],
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("Masukan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: DiyoThemeFont.sizeBodyCopy,
                                        color: DiyoThemeFont.blackFontColor)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              int totalQty = checkoutController.getTotalQtyCartItem();
              int total = checkoutController.getTotalCartItem();
              return Positioned(
                  bottom: 0,
                  left: 0,
                  child: totalQty == 0
                      ? const SizedBox.shrink()
                      : BasketButton(
                          onTap: checkOutHandle,
                          qty: totalQty,
                          text: "Checkout",
                          total: total));
            })
          ],
        ));
  }
}
