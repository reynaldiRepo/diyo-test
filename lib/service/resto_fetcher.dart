import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyo/model/resto.dart';
import 'package:diyo/util/util.dart';

class RestoFetcher {
  static final db = FirebaseFirestore.instance;

  static Future<List<Resto>> getAllResto() async {
    List<Resto> restoList = [];
    try {
      var restoSnapShoot = await db
          .collection("resto")
          .orderBy("id", descending: false)
          .get(const GetOptions(source: Source.server));
      for (var resto in restoSnapShoot.docs) {
        var tempResto = Resto.jsonToObject(resto.data());
        DiyoUtill.logger.d(tempResto.toJson());
        restoList.add(tempResto);
      }
    } catch (e, stacktrace) {
      DiyoUtill.logger.e(e);
      DiyoUtill.logger.e(stacktrace);
    }
    return restoList;
  }
}
