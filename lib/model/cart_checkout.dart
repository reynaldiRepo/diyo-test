import 'package:diyo/model/menu.dart';
import 'package:diyo/model/resto.dart';

class CartItem {
  Menu menu;
  int qty;
  String request;
  CartItem({required this.menu, required this.qty, this.request = ""});
}

class CheckoutSummary {
  List<CartItem> cartItem;
  Resto resto;
  String mejaCode;
  DateTime time;

  int getTotalQty() {
    int res = 0;
    for (var element in cartItem) {
      res += element.qty;
    }
    return res;
  }

  int getTotalPrice() {
    int res = 0;
    for (var element in cartItem) {
      res += (element.qty * element.menu.price);
    }
    return res;
  }

  CheckoutSummary(
      {required this.cartItem,
      required this.resto,
      required this.mejaCode,
      required this.time});
}
