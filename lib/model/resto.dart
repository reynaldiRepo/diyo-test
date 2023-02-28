import 'package:diyo/model/menu_category.dart';
import 'package:diyo/util/time_to_today.dart';
import 'package:diyo/util/util.dart';
import 'package:intl/intl.dart';

class Resto {
  String address;
  String category;
  DateTime? closing;
  DateTime? opening;
  int id;
  String image;
  String name;
  List<MenuCategory> menuCategory = [];

  Resto(
      {this.address = "",
      this.category = "",
      this.closing,
      this.opening,
      this.id = 0,
      this.image = "",
      this.name = "",
      this.menuCategory = const []});

  void menuCategoryJsonToProperty(List<dynamic> data) {
    var tempMenuCategory = <MenuCategory>[];
    for (var menuCat in data) {
      try {
        if (menuCat.containsKey("id") && menuCat.containsKey("name")) {
          tempMenuCategory
              .add(MenuCategory(name: menuCat['name'], id: menuCat['id']));
        }
      } catch (e) {
        DiyoUtill.logger.e(e);
      }
    }
    menuCategory = tempMenuCategory;
  }

  static Resto jsonToObject(Map<String, dynamic> data) {
    Resto resto = Resto(
      address: data['address'] ?? "",
      category: data['category'] ?? "",
      closing: TimeToToday.hourFormatToDate(data['closing']),
      opening: TimeToToday.hourFormatToDate(data['opening']),
      id: data['id'] ?? 0,
      image: data['image'] ?? "",
      name: data['name'] ?? "",
    );

    resto.menuCategoryJsonToProperty(data['menu_category'] ?? []);

    return resto;
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'category': category,
      'closing': DateFormat("HH:mm").format(closing ?? DateTime.now()),
      'opening': DateFormat("HH:mm").format(opening ?? DateTime.now()),
      'id': id,
      'image': image,
      'name': name,
      'menuCategory': menuCategory
    };
  }

  String getFormattedClosing() {
    return DateFormat("HH:mm").format(closing ?? DateTime.now());
  }

  String getFormattedOpenning() {
    return DateFormat("HH:mm").format(opening ?? DateTime.now());
  }

  bool isStillOpen() {
    var now = DateTime.now();
    DiyoUtill.logger.d([closing, opening, now]);
    if (now.isAfter(closing ?? DateTime.now()) ||
        now.isBefore(opening ?? DateTime.now())) {
      return false;
    }
    return true;
  }
}
