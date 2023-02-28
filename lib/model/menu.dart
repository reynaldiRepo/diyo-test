import 'package:diyo/util/util.dart';

class Menu {
  int category_id;
  int id;
  String image;
  String name;
  int price;
  int resto_id;

  Menu({
    required this.category_id,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.resto_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_id': category_id,
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'resto_id': resto_id
    };
  }

  static Menu empty() {
    return Menu(
        category_id: 0,
        id: 0,
        image:
            "https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg",
        name: "",
        price: 0,
        resto_id: 0);
  }

  static Menu? jsonToObject(Map<String, dynamic> data) {
    try {
      return Menu(
        category_id: data['category_id'] ?? 0,
        id: data['id'] ?? 0,
        resto_id: data['resto_i'] ?? 0,
        price: data['price'] ?? 0,
        image: data['image'] ?? "",
        name: data['name'] ?? "",
      );
    } catch (e) {
      DiyoUtill.logger.e(e);
      return null;
    }
  }
}
