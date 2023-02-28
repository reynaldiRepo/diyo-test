import 'package:diyo/model/cart_checkout.dart';
import 'package:diyo/model/menu.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  RxList<CartItem> listCartItem = <CartItem>[].obs;
  RxList<CheckoutSummary> listCheckOut = <CheckoutSummary>[].obs;
  Rx<Menu> viewedMenu = Menu.empty().obs;

  void setViewedMenu(Menu menu) {
    viewedMenu.value = menu;
  }

  void addListCartItemQTYAndUpdateRequest(Menu menu, String request) {
    var idx = listCartItem.indexWhere((element) => element.menu.id == menu.id);
    if (idx != -1) {
      listCartItem[idx].qty += 1;
    } else {
      listCartItem.add(CartItem(menu: menu, qty: 1));
    }
    listCartItem.refresh();
  }

  void substractListCartItemQTY(Menu menu) {
    var idx = listCartItem.indexWhere((element) => element.menu.id == menu.id);
    if (idx != -1) {
      listCartItem[idx].qty -= 1;
      if (listCartItem[idx].qty == 0) {
        listCartItem.removeAt(idx);
      }
    }
    listCartItem.refresh();
  }

  void updateRequestByMenu(Menu menu, String request) {
    var idx = listCartItem.indexWhere((element) => element.menu.id == menu.id);
    if (idx != -1) {
      listCartItem[idx].request = request;
    }
    listCartItem.refresh();
  }

  String getRequestByMenu(Menu menu) {
    var idx = listCartItem.indexWhere((element) => element.menu.id == menu.id);
    if (idx != -1) {
      return listCartItem[idx].request;
    }
    return "";
  }

  int getTotalCartItem() {
    var res = 0;
    for (var element in listCartItem) {
      res += (element.menu.price * element.qty);
    }
    return res;
  }

  int getTotalQtyCartItem() {
    var res = 0;
    for (var element in listCartItem) {
      res += element.qty;
    }
    return res;
  }

  int getTotalCartItemQtyByMenu(Menu menu) {
    if (listCartItem.where((p0) => p0.menu.id == menu.id).isNotEmpty) {
      return listCartItem.where((p0) => p0.menu.id == menu.id).first.qty;
    }
    return 0;
  }

  int getTotalCartItemByMenu(Menu menu) {
    return getTotalCartItemQtyByMenu(menu) * menu.price;
  }

  void deleteCartItem(CartItem cartItem) {
    listCartItem.removeWhere((element) => element.menu.id == cartItem.menu.id);
    listCartItem.refresh();
  }

  void clearCartItem() {
    listCartItem.clear();
    listCartItem.refresh();
  }

  void addCheckOutSummary(CheckoutSummary checkoutSummary) {
    listCheckOut.add(checkoutSummary);
    listCheckOut.refresh();
  }
}
