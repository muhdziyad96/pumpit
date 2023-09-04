import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pumpit/constant/api_key.dart';
import 'package:pumpit/controller/map_controller.dart';
import 'package:pumpit/model/google_map_model.dart';

class GoogleMapService {
  MapController m = Get.find();
  Future<List<Result>> mapMakerList(keyword, currentLat, currentLang) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keyword&location=$currentLat,$currentLang&radius=1500&type=gas station&key=$api_key"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final responseData = json.decode(response.body);
      var results = responseData['results'];
      List<Result> gasStations =
          List.from(results.map((data) => Result.fromJson(data)));

      print(responseData['status']);
      return gasStations;
    } catch (e) {
      return Future.error(e);
    }
  }
}
