import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class GeoLocatorService {
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      var errorText = 'Location services are disabled.';
      Get.snackbar(
        'status'.tr,
        errorText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 8,
        margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.23.h),
        duration: const Duration(seconds: 2),
      );
      return Future.error(errorText);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        var errorText = 'Location permissions are denied';
        Get.snackbar(
          'status'.tr,
          errorText,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 8,
          margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.23.h),
          duration: const Duration(seconds: 2),
        );
        return Future.error(errorText);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      var errorText =
          'Location permissions are permanently denied, we cannot request permissions.';
      Get.snackbar(
        'status'.tr,
        errorText,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 8,
        margin: EdgeInsets.symmetric(horizontal: 4.2.w, vertical: 1.23.h),
        duration: const Duration(seconds: 2),
      );
      return await Future.error(errorText);
    }

    return await Geolocator.getCurrentPosition();
  }
}
