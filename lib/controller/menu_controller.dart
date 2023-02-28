import 'package:diyo/model/menu.dart';
import 'package:diyo/service/menu_fetcher.dart';
import 'package:diyo/util/util.dart';
import 'package:get/state_manager.dart';

class MenuController extends GetxController {
  RxList<Menu> menuList = <Menu>[].obs;
  RxBool isLoading = false.obs;

  void clearMenu() {
    menuList.clear();
    menuList.refresh();
  }

  void getMenuByResto(int restoID) async {
    isLoading.value = true;
    try {
      menuList.clear();
      menuList.value = await MenuFetcher.getAllMenu(restoID);
    } catch (e, st) {
      menuList.value = [];
      DiyoUtill.logger.e(e);
      DiyoUtill.logger.e(st);
    }
    isLoading.value = false;
  }
}
