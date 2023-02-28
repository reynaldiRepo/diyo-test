import 'package:cached_network_image/cached_network_image.dart';
import 'package:diyo/component/basket_button.dart';
import 'package:diyo/component/diyo_scaffold.dart';
import 'package:diyo/component/diyo_shimmer.dart';
import 'package:diyo/component/menu_card.dart';
import 'package:diyo/component/menu_card_placeholder.dart';
import 'package:diyo/controller/checkout_controller.dart';
import 'package:diyo/controller/menu_controller.dart';
import 'package:diyo/controller/resto_controller.dart';
import 'package:diyo/model/menu_category.dart';
import 'package:diyo/util/theme_color.dart';
import 'package:diyo/util/theme_font.dart';
import 'package:diyo/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestoDetailSection extends StatelessWidget {
  RestoDetailSection({super.key});
  final RestoController restoController = Get.find<RestoController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restoController.viewedResto.value.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DiyoThemeFont.sizeH2,
                  color: DiyoThemeFont.blackFontColor,
                  fontWeight: FontWeight.w900)),
          const SizedBox(
            height: 12,
          ),
          Text(restoController.viewedResto.value.category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DiyoThemeFont.sizeBodyCopy,
                  color: DiyoThemeFont.blackFontColor,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 8,
          ),
          Text(restoController.viewedResto.value.address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: DiyoThemeFont.sizeBodyCopy,
                  color: DiyoThemeFont.blackFontColor,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: DiyoTheme.diyotheme,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      restoController.viewedResto.value.isStillOpen()
                          ? "Buka"
                          : "Closed",
                      style: TextStyle(
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                          color: DiyoTheme.diyotheme,
                          fontSize: DiyoThemeFont.sizeH3),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      restoController.viewedResto.value.isStillOpen()
                          ? "until ${restoController.viewedResto.value.getFormattedClosing()} today"
                          : "Open at ${restoController.viewedResto.value.getFormattedOpenning()}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.2,
                          fontWeight: FontWeight.w400,
                          color: DiyoThemeFont.blackFontColor,
                          fontSize: DiyoThemeFont.sizeBodyCopy),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: const BoxDecoration(
                  color: DiyoTheme.diyotheme,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.pin_drop,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "1.2 km",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.2,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: DiyoThemeFont.sizeBodyCopy),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class RestoHero extends StatelessWidget {
  final bool isFavorit;
  final void Function()? onFavoriteTap;
  RestoHero({super.key, this.isFavorit = false, this.onFavoriteTap});
  final RestoController restoController = Get.find<RestoController>();
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
            imageUrl: restoController.viewedResto.value.image,
          )),
          Positioned(
            top: 12,
            left: 16,
            child: GestureDetector(
              onTap: () async {
                var confirm = await DiyoUtill.menuDetailBagDialog(context);
                if (confirm) {
                  Navigator.pop(context);
                  return;
                }
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
          ),
          Positioned(
            bottom: 12,
            left: 16,
            child: Container(
                decoration: BoxDecoration(
                    color: DiyoTheme.diyotheme,
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.table_restaurant_outlined,
                      color: Colors.white70,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text("No. Meja ${restoController.mejaActive.value}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: DiyoThemeFont.sizeBodyCopy,
                            fontWeight: FontWeight.w900))
                  ],
                )),
          ),
          Positioned(
              bottom: -22.5,
              right: 16,
              child: GestureDetector(
                onTap: onFavoriteTap,
                child: Container(
                  alignment: Alignment.center,
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45)),
                  child: Icon(
                    isFavorit ? Icons.favorite : Icons.favorite_outline,
                    color: DiyoTheme.diyotheme,
                    size: 28,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class MenuCategoryItem extends StatelessWidget {
  final MenuCategory menuCategory;
  final bool isActive;
  final void Function()? onTap;
  const MenuCategoryItem(
      {super.key,
      required this.menuCategory,
      required this.isActive,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
            color: isActive ? DiyoTheme.diyotheme : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          menuCategory.name,
          style: TextStyle(
              color: isActive ? Colors.white : DiyoThemeFont.blackFontColor,
              fontWeight: FontWeight.w400,
              fontSize: DiyoThemeFont.sizeBodyCopy),
        ),
      ),
    );
  }
}

class RestoDetail extends StatefulWidget {
  const RestoDetail({super.key});
  @override
  State<RestoDetail> createState() => _RestoDetailState();
}

class _RestoDetailState extends State<RestoDetail> {
  RestoController restoController = Get.find<RestoController>();
  MenuController menuController = Get.find<MenuController>();
  CheckoutController checkoutController = Get.find<CheckoutController>();

  int activeCategory = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        activeCategory =
            restoController.viewedResto.value.menuCategory.first.id;
      });
      menuController.getMenuByResto(restoController.viewedResto.value.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => DiyoUtill.menuDetailBagDialog(context),
      child: DiyoScaffold(
        useBottomBar: false,
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
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
                      Obx(() => RestoHero(
                            onFavoriteTap: () =>
                                restoController.toggleRestoFavorit(
                                    restoController.viewedResto.value),
                            isFavorit: restoController.checkRestoIsFavorit(
                                restoController.viewedResto.value),
                          )),
                      RestoDetailSection(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: MediaQuery.of(context).size.width,
                        height: DiyoThemeFont.sizeH2 * 1.8,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: restoController
                              .viewedResto.value.menuCategory.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            MenuCategory _ = restoController
                                .viewedResto.value.menuCategory[index];
                            return MenuCategoryItem(
                                onTap: () => setState(() {
                                      activeCategory = _.id;
                                    }),
                                isActive: _.id == activeCategory,
                                menuCategory: _);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Obx(() {
                          var listFilteredMenu = menuController.menuList
                              .where((p0) => p0.category_id == activeCategory)
                              .toList();
                          return ListView.builder(
                            itemCount: menuController.isLoading.isTrue
                                ? 10
                                : listFilteredMenu.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (menuController.isLoading.isTrue) {
                                return const MenuCardPlaceHolder(
                                    key: Key("MenuPlaceHolder"));
                              }
                              return MenuCard(
                                menu: listFilteredMenu[index],
                                onTap: () {
                                  var _menu = listFilteredMenu[index];
                                  checkoutController.setViewedMenu(_menu);
                                  Get.toNamed("/menu-detail",
                                      preventDuplicates: false);
                                },
                              );
                            },
                          );
                        }),
                      )
                    ],
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
                  child: checkoutController.listCartItem.isEmpty
                      ? const SizedBox.shrink()
                      : BasketButton(
                          onTap: () => Get.toNamed("/checkout"),
                          qty: totalQty,
                          text: "View Basket",
                          total: total));
            })
          ],
        ),
      ),
    );
  }
}
