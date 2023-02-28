import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt indexBottomBar = 0.obs;

  void setIndexBottomBar(int idx) {
    indexBottomBar.value = idx;
  }
}
