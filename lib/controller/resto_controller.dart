import 'package:diyo/model/resto.dart';
import 'package:diyo/service/resto_fetcher.dart';
import 'package:get/get.dart';

class RestoController extends GetxController {
  var isLoadResto = false.obs;
  RxList<Resto> restoList = <Resto>[].obs;
  RxList<Resto> favoritList = <Resto>[].obs;
  Rx<Resto> viewedResto = Resto().obs;
  Rx<Resto> expectedViewedResto = Resto().obs;
  RxInt mejaActive = 0.obs;

  @override
  onReady() {
    getResto();
    super.onReady();
  }

  bool checkRestoIsFavorit(Resto resto) {
    return favoritList.where((p0) => p0.id == resto.id).isNotEmpty;
  }

  void toggleRestoFavorit(Resto resto) {
    var idx = favoritList.indexWhere((element) => element.id == resto.id);
    if (idx == -1) {
      favoritList.add(resto);
    } else {
      favoritList.removeAt(idx);
    }
    favoritList.refresh();
  }

  void setMejaActive(int noMeja) {
    mejaActive.value = noMeja;
  }

  void setViewedResto(Resto resto) {
    viewedResto.value = resto;
  }

  void setExpectedViewedresto(Resto resto) {
    expectedViewedResto.value = resto;
  }

  Future<void> getResto() async {
    isLoadResto.value = true;
    restoList.value = await RestoFetcher.getAllResto();
    isLoadResto.value = false;
  }
}
