import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/bottom_nav_bar_controller.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/favourites_controller.dart';
import '../components/food_tab.dart';
import '../components/fruits_tab.dart';
import '../components/grocery_tab.dart';
import '../components/vegetables_tab.dart';
import '../../globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavBarController bottomNavBarController =
      Get.put(BottomNavBarController());

  FavouritesController favouritesController = Get.put(FavouritesController());

  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/cart_screen');
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.shopping_cart_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(
        () {
          return bottomNavBarController
              .navBarPages[bottomNavBarController.initialNavBarIndex.value];
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return AnimatedBottomNavigationBar(
            icons: const [
              Icons.home,
              Icons.message,
              Icons.notifications,
              Icons.favorite_border,
            ],
            activeColor: Colors.green,
            activeIndex: bottomNavBarController.initialNavBarIndex.value,
            onTap: (i) {
              bottomNavBarController.navBarIndex(index: i);
            },
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int initialTabIndex = 0;

  List<Widget> tabs = [
    foodTab(),
    fruitsTab(),
    vegetablesTab(),
    groceryTab(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 46),
                  Row(
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
                      const Icon(
                        Icons.location_on_sharp,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "$city,$state",
                        style: GoogleFonts.ubuntu(
                          color: Colors.grey,
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
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Hi, Paras",
                      style: GoogleFonts.ubuntu(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Find your food",
                      style: GoogleFonts.ubuntu(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabled: true,
                        fillColor: Colors.green.shade50,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                        hintText: "Search Food",
                        suffixIcon: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            collapseMode: CollapseMode.parallax,
          ),
          toolbarHeight: 210,
          bottom: TabBar(
            onTap: (i) {
              initialTabIndex = i;
            },
            controller: tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.green,
            labelStyle: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: const [
              Tab(text: "Food"),
              Tab(text: "Fruits"),
              Tab(text: "Vegetables"),
              Tab(text: "Grocery"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          controller: tabController,
          children: tabs,
        ),
      ),
    );
  }
}
