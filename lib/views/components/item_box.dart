import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favourites_controller.dart';
import '../../modals/item_modal.dart';

final CartController cartController = Get.find<CartController>();
itemBox(
    {required String id,
    required String image,
    required String name,
    required int price,
    required String ratings,
    required String time,
    required bool isFavourite,
    required int quantity,
    required Item item,
    required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GetBuilder(
                //init: FavouritesController(),
                builder: (FavouritesController controller) => IconButton(
                      onPressed: () {
                        if (isFavourite != true) {
                          controller.changeFavouriteStatus(
                              isFavourite: isFavourite, id: id);
                          controller.addToFavourites(item: item);
                          print(isFavourite);
                        } else if (isFavourite == true) {
                          controller.changeFavouriteStatus(
                              isFavourite: isFavourite, id: id);
                          controller.removeFromFavourites(item: item, id: id);
                          print(isFavourite);
                        }
                      },
                      icon: (isFavourite)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border),
                    ))
          ],
        ),
        InkWell(
          onTap: () {
            Arguments args = Arguments(
              id: id,
              name: name,
              price: price,
              ratings: ratings,
              time: time,
              image: image,
              isFavourite: isFavourite,
              quantity: 0,
              item: Item(
                  id: id,
                  name: name,
                  price: price,
                  ratings: ratings,
                  deliveryTime: time,
                  image: image,
                  isFavourite: isFavourite,
                  quantity: 0),
            );
            Get.toNamed('/details_screen', arguments: args);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.01),
                radius: 64,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 14),
                  Text(
                    "$time min",
                    style: GoogleFonts.ubuntu(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "⭐ $ratings",
                    style: GoogleFonts.ubuntu(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(width: 14),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 14),
            Text(
              "Rs. $price",
              style: GoogleFonts.ubuntu(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                cartController.addToCart(
                    item: Item(
                        id: id,
                        name: name,
                        price: price,
                        ratings: ratings,
                        deliveryTime: time,
                        image: image,
                        isFavourite: isFavourite,
                        quantity: quantity));

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "$name added to cart...",
                      style: GoogleFonts.ubuntu(),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.black,
                    action: SnackBarAction(
                      onPressed: () {},
                      label: "Dismiss",
                    ),
                  ),
                );
              },
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ],
    ),
  );
}

class Arguments {
  final String id;
  final String name;
  final int price;
  final String ratings;
  final String time;
  final String image;
  bool isFavourite;
  int quantity;
  final Item item;

  Arguments(
      {required this.id,
      required this.name,
      required this.price,
      required this.ratings,
      required this.time,
      required this.image,
      required this.isFavourite,
      required this.item,
      required this.quantity});
}
