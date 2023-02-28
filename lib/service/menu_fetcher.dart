import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyo/model/menu.dart';
import 'package:diyo/util/util.dart';

class MenuFetcher {
  static final db = FirebaseFirestore.instance;

  static Future<List<Menu>> getAllMenu(int restoID) async {
    List<Menu> menuList = [];
    try {
      var menuSnapShoot = await db
          .collection("menu")
          .where("resto_id", isEqualTo: restoID)
          .orderBy("id", descending: false)
          .get(const GetOptions(source: Source.server));
      for (var menu in menuSnapShoot.docs) {
        var tempMenu = Menu.jsonToObject(menu.data());
        if (tempMenu != null) {
          DiyoUtill.logger.d(tempMenu.toJson());
          menuList.add(tempMenu);
        }
      }
    } catch (e, stacktrace) {
      DiyoUtill.logger.e(e);
      DiyoUtill.logger.e(stacktrace);
    }
    return menuList;
  }
}
