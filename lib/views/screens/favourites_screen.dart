import 'package:flutter/material.dart';
import 'package:food_app/controllers/favourites_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../modals/item_modal.dart';
import '../components/item_box.dart';

final FavouritesController favouritesController =
    Get.find<FavouritesController>();

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(
                  "Favourites",
                  style: GoogleFonts.ubuntu(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: FlutterLogo(),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          Expanded(
            flex: 14,
            child: (favouritesController.favouriteItems.isEmpty)
                ? GetBuilder(
                    builder: (FavouritesController controller) => Center(
                          child: Text(
                            controller.status,
                            style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ))
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: GetBuilder(
                      //  init: FavouritesController(),
                      builder: (FavouritesController controller) =>
                          GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 275,
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: controller.favouriteItems.length,
                        itemBuilder: (context, i) {
                          Item data = controller.favouriteItems[i];

                          return itemBox(
                              id: data.id,
                              name: data.name,
                              price: data.price,
                              time: data.deliveryTime,
                              item: data,
                              isFavourite: data.isFavourite,
                              ratings: data.ratings,
                              image: data.image,
                              quantity: 0,
                              context: context);
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
