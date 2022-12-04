import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favourites_controller.dart';
import '../components/item_box.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextStyle txtStyle = GoogleFonts.ubuntu(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  bool favouriteStatus = false;

  final FavouritesController favouritesController =
      Get.find<FavouritesController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    Arguments res = ModalRoute.of(context)!.settings.arguments as Arguments;
    favouriteStatus = res.isFavourite;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          const SizedBox(height: 42),
          Row(
            children: [
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "Food Details",
                style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GetBuilder(
                  //  init: FavouritesController(),
                  builder: (FavouritesController controller) {
                return InkWell(
                  onTap: () {
                    if (favouriteStatus != true) {
                      controller.changeFavouriteStatus(
                          isFavourite: favouriteStatus, id: res.id);
                      controller.addToFavourites(item: res.item);
                      favouriteStatus = true;
                      //  print(res.isFavourite);
                    } else if (favouriteStatus == true) {
                      controller.changeFavouriteStatus(
                          isFavourite: favouriteStatus, id: res.id);
                      controller.removeFromFavourites(
                          item: res.item, id: res.id);
                      favouriteStatus = false;
                      //   print(res.isFavourite);
                    }
                    // controller.currentBoolVal = !controller.currentBoolVal;
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      (favouriteStatus)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: (favouriteStatus) ? Colors.red : Colors.white,
                      size: 32,
                    ),
                  ),
                );
              }),
              const SizedBox(width: 12),
            ],
          ),
          const Spacer(),
          Stack(
            alignment: const Alignment(0, -1.40),
            children: [
              Container(
                height: Get.height * 0.7,
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.16),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              res.name,
                              style: GoogleFonts.ubuntu(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Rs ${res.price}",
                              style: GoogleFonts.ubuntu(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 55,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              const Spacer(flex: 2),
                              IconButton(
                                  onPressed: () {
                                    if (cartController.quantity > 0) {
                                      cartController.quantity--;
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                              const Spacer(),
                              Obx(() => Text(
                                    "${cartController.quantity}",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    cartController.quantity++;
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("⭐ ${res.ratings}", style: txtStyle),
                        Text(
                          "🩸 100 Kcal",
                          style: txtStyle,
                        ),
                        Text("⌚ ${res.time} min", style: txtStyle),
                      ],
                    ),
                    const SizedBox(height: 44),
                    Text(
                      "About food",
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ReadMoreText(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages",
                      style: GoogleFonts.ubuntu(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      colorClickableText: Colors.green,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                    ),
                    const Spacer(),
                    Container(
                      height: 65,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(vertical: 18),
                      child: ElevatedButton(
                        onPressed: () {
                          if (cartController.quantity > 0) {
                            cartController.addToCart(item: res.item);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${res.name} added to cart...",
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
                          } else if (cartController.quantity == 0.obs) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Quantity must be greater than 0",
                                  style: GoogleFonts.ubuntu(),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                action: SnackBarAction(
                                  onPressed: () {},
                                  label: "Dismiss",
                                  textColor: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: GoogleFonts.ubuntu(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        res.image,
                      ),
                      fit: BoxFit.fill,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cartController.quantity = 0.obs;
  }
}
