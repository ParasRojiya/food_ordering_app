import 'package:get/get.dart';

import '../helpers/cloud_firestore_helper.dart';
import '../modals/item_modal.dart';

class FavouritesController extends GetxController {
  List<Item> favouriteItems = <Item>[];
  String status = 'Press ♥ in product card\nto add item in your favourite list';

  addToFavourites({required Item item}) async {
    item.isFavourite = true;

    if (favouriteItems.isEmpty) {
      CloudFirestoreHelper.cloudFirestoreHelper
          .addToFavourites(id: item.id, data: item);

      favouriteItems.add(item);
    } else {
      for (int i = 0; i < favouriteItems.length; i++) {
        if (item.id != favouriteItems[i].id) {
          CloudFirestoreHelper.cloudFirestoreHelper
              .addToFavourites(id: item.id, data: item);
          favouriteItems.add(item);

          break;
        }
      }
    }

    favouriteItems.toSet().toList();
    update();
  }

  removeFromFavourites({required Item item, required String id}) async {
    for (int i = 0; i < favouriteItems.length; i++) {
      if (id == favouriteItems[i].id) {
        CloudFirestoreHelper.cloudFirestoreHelper.removeFromFavourites(id: id);

        favouriteItems.removeAt(i);
        break;
      }
    }

    favouriteItems.toSet().toList();
    update();
  }

  changeFavouriteStatus({required bool isFavourite, required String id}) {
    isFavourite = !isFavourite;

    Map<String, dynamic> data = {
      "isFavourite": isFavourite,
    };

    CloudFirestoreHelper.cloudFirestoreHelper
        .updateFavouriteStatus(data: data, id: id);
    update();
  }
}
