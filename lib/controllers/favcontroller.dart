import 'package:get/get.dart';
import 'package:movarsh/main.dart';
import 'package:movarsh/model/moviemodel.dart';
import 'package:movarsh/model/tvmodel.dart';

import '../constant/database/database.dart';

class FavController extends GetxController {
  Sql sql = Sql();
  List fav = [];
  List get getFav => fav;
  addtoFav(MovieModel model) {
    fav.add(model);
    sql.insertData(model);

    update();
  }

  removefav(int model) {
    fav.removeWhere((element) => element.id == model);
    update();
  }

  getidfav(id) {
    bool isfav = false;
    fav.forEach((element) {
      if (element.id == id) {
        isfav = true;
      } else {
        isfav = false;
      }
    });
    return isfav;
  }

  List favTv = [];
  List get getFavTv => favTv;
  addtoFavTv(TvModel model) {
    favTv.add(model);
    update();
  }

  removefavTV(int model) {
    favTv.removeWhere((element) => element.id == model);
    update();
  }

  getidfavTv(id) {
    bool isfavTv = false;
    favTv.forEach((element) {
      if (element.id == id) {
        isfavTv = true;
      } else {
        isfavTv = false;
      }
    });
    return isfavTv;
  }
}
