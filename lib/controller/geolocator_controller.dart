import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeoLocatorController extends GetxController {
  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var isLoading = false;

  void setLatLng(Position val) {
    lat.value = val.latitude;
    lng.value = val.longitude;
    update();
  }
}
