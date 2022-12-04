import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/cart_controller.dart';
import '../../modals/item_modal.dart';

final CartController cartController = Get.find<CartController>();

TextStyle titleStyle = GoogleFonts.ubuntu(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        color: Colors.green,
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
                    "🛒 Cart",
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
              child: GetBuilder(
                  builder: (CartController controller) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cartController.cartItems.length,
                          itemBuilder: (context, i) {
                            Item data = cartController.cartItems[i];

                            return Container(
                              width: Get.width,
                              height: Get.height * 0.3,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8),
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.01),
                                    backgroundImage: NetworkImage(
                                      data.image,
                                    ),
                                    radius: 65,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    data.name,
                                    style: titleStyle,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${data.deliveryTime} min",
                                        style: GoogleFonts.ubuntu(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "⭐ ${data.ratings}",
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  Row(
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            const Spacer(flex: 2),
                                            IconButton(
                                                onPressed: () {
                                                  cartController.removeFromCart(
                                                      item: data);
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                )),
                                            const Spacer(),
                                            Text(
                                              "${data.quantity}",
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  cartController.addToCart(
                                                      item: data);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                )),
                                            const Spacer(flex: 2),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Price:-Rs.${data.price}",
                                        style: GoogleFonts.ubuntu(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )),
            ),
            Expanded(
              flex: (cartController.totalQuantity as RxInt > 0) ? 3 : 2,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "TotalQuantity:-",
                          style: titleStyle,
                        ),
                        const Spacer(),
                        GetBuilder(
                          builder: (CartController controller) => Text(
                            "${cartController.totalQuantity}",
                            style: titleStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "TotalPrice:-",
                          style: titleStyle,
                        ),
                        const Spacer(),
                        GetBuilder(
                          builder: (CartController controller) => Text(
                            "Rs. ${cartController.totalPrice}",
                            style: titleStyle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    (cartController.totalQuantity as RxInt > 0)
                        ? Container(
                            width: Get.width,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Your order has been successfully placed...",
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                "Place your order",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
