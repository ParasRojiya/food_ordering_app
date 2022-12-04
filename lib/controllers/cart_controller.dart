import 'package:get/get.dart';
import '../modals/item_modal.dart';

class CartController extends GetxController {
  RxList<Item> cartItems = <Item>[].obs;
  RxInt quantity = 0.obs;

  addToCart({required Item item}) {
    RxBool containsValue = false.obs;
    if (cartItems.isEmpty) {
      item.quantity++;
      cartItems.add(item);
    } else {
      for (Item product in cartItems) {
        if (product.name == item.name) {
          containsValue = true.obs;
          break;
        }
      }

      if (containsValue == true.obs) {
        cartItems[cartItems.indexOf(item)].quantity++;
      } else {
        item.quantity++;
        cartItems.add(item);
      }
    }

    update();
  }

  removeFromCart({required Item item}) {
    if (item.quantity > 1) {
      cartItems[cartItems.indexOf(item)].quantity--;
    } else {
      cartItems.remove(item);
    }
    update();
  }

  get totalQuantity {
    RxInt quantity = 0.obs;
    for (Item item in cartItems) {
      quantity += item.quantity;
    }

    return quantity;
  }

  get totalPrice {
    RxInt price = 0.obs;
    for (Item item in cartItems) {
      if (item.quantity > 0) {
        price = price + (item.price * item.quantity);
      }
    }

    return price;
  }
}
