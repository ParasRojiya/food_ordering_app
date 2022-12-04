import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/screens/chats_screen.dart';
import '../views/screens/favourites_screen.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/notification_screen.dart';

class BottomNavBarController extends GetxController {
  RxList<Widget> navBarPages = [
    const Home(),
    const ChatsPage(),
    const NotificationPage(),
    const FavouritesPage(),
  ].obs;

  RxInt initialNavBarIndex = 0.obs;

  navBarIndex({required int index}) {
    initialNavBarIndex.value = index;
  }
}
