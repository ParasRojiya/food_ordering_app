import 'package:flutter/material.dart';
import 'package:food_app/views/screens/cart_screen.dart';
import 'package:get/get.dart';
import 'views/screens/splash_screen.dart';
import 'views/screens/home_screen.dart';
import 'views/screens/details_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      getPages: <GetPage>[
        GetPage(name: '/splash_screen', page: () => const SplashScreen()),
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/details_screen', page: () => const DetailsPage()),
        GetPage(name: '/cart_screen', page: () => const CartPage())
      ],
    ),
  );
}
