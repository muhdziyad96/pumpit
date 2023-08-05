import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pumpit/controller/geolocator_controller.dart';
import 'package:pumpit/model/google_map_model.dart';
import 'package:pumpit/service/google_map_service.dart';

class MapController extends GetxController {
  GeoLocatorController g = Get.find();
  List<Marker> markerList = [];
  var markerListData = <Result>[].obs;

  @override
  void onInit() {
    // getMarkerList(null);
    super.onInit();
  }

  void clearMarker() {
    markerList.clear();
    update();
  }

  Future<void> getMarkerList(keyword) async {
    List<Result> response =
        await GoogleMapService().mapMakerList(keyword, g.lat, g.lng);
    // await GoogleMapService().mapMakerList(keyword, 3.179420, 101.690880);
    if (response == []) {
      clearMarker();
    }
    markerListData.value = response;
    clearMarker();
    for (var i = 0; i < response.length; i++) {
      markerList.add(
        Marker(
          markerId: MarkerId(response[i].placeId),
          position: LatLng(response[i].geometry.location.lat,
              response[i].geometry.location.lng),
          infoWindow: InfoWindow(title: response[i].name),
        ),
      );
    }
    update();
  }
}
