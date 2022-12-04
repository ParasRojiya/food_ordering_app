import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../globals.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double lat = 0;
  double lon = 0;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    lat = position.latitude;
    lon = position.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    city = placemarks[0].locality ?? "City";
    state = placemarks[0].administrativeArea ?? "State";
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/splash_image.png",
              height: 320,
              width: 320,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40),
            Text(
              "Fast deliver at\nyour doorstep",
              style: GoogleFonts.ubuntu(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Home delivery and online reservation\nsystem for restaurants & cafe",
              style: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Container(
              width: Get.width,
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.offNamed('/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  textStyle: GoogleFonts.ubuntu(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text("Let's Explore"),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
