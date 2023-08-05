import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pumpit/constant/api_key.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/geolocator_controller.dart';
import 'package:pumpit/controller/map_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController m = Get.put(MapController());
  GeoLocatorController g = Get.find();
  List<LatLng> cordinateLocation = [];
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng? currentLocation = LatLng(g.lat.value, g.lng.value);
  // late LatLng? currentLocation = const LatLng(3.179420, 101.690880);
  late CameraPosition? currentPosition = CameraPosition(
    target: currentLocation!,
    zoom: 14,
  );
  bool visibleLine = false;

  @override
  void initState() {
    super.initState();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void getPolyPoints(lat, lang) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      api_key,
      PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
      PointLatLng(lat, lang),
    );
    cordinateLocation.clear();
    if (result.points.isNotEmpty) {
      for (var element in result.points) {
        cordinateLocation.add(LatLng(element.latitude, element.longitude));
      }
      visibleLine = true;
      setState(() {});
    }
  }

  void deletePoint() async {
    visibleLine = false;
    cordinateLocation.clear();
    setState(() {});
  }

  void launchWaze(double lat, double lng) async {
    var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
    try {
      bool launched = await launchUrl(
        Uri.parse(url),
      );
      if (!launched) {
        await launchUrl(
          Uri.parse(fallbackUrl),
        );
      }
    } catch (e) {
      await launchUrl(
        Uri.parse(fallbackUrl),
      );
    }
  }

  void launchGoogleMaps(double lat, double lng) async {
    var url = 'google.navigation:q=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}';
    try {
      bool launched = await launchUrl(
        Uri.parse(url),
      );
      if (!launched) {
        await launchUrl(
          Uri.parse(fallbackUrl),
        );
      }
    } catch (e) {
      await launchUrl(
        Uri.parse(fallbackUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: const Icon(PhosphorIcons.magnifyingGlass),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Shell"),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Petron"),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Petronas"),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("Bh Petrol"),
                  ),
                  const PopupMenuItem<int>(
                    value: 4,
                    child: Text("Caltex"),
                  ),
                  const PopupMenuItem<int>(
                    value: 5,
                    child: Text("All"),
                  ),
                ];
              },
              onSelected: (value) async {
                deletePoint();
                switch (value) {
                  case 0:
                    {
                      await m.getMarkerList('Shell').then((value) {
                        setState(() {});
                      });
                    }
                    break;
                  case 1:
                    {
                      m.getMarkerList('Petron').then((value) {
                        setState(() {});
                      });
                    }
                    break;
                  case 2:
                    {
                      m.getMarkerList('Petronas').then((value) {
                        setState(() {});
                      });
                    }
                    break;
                  case 3:
                    {
                      m.getMarkerList('Bh Petrol').then((value) {
                        setState(() {});
                      });
                    }
                    break;
                  case 4:
                    {
                      m.getMarkerList('Caltex').then((value) {
                        setState(() {});
                      });
                    }
                    break;
                  case 5:
                    {
                      m.getMarkerList('gas').then((value) {
                        setState(() {});
                      });
                    }
                    break;
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: GoogleMap(
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: currentPosition!,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: cordinateLocation,
                    color: primaryColor,
                    width: 3,
                    visible: visibleLine,
                  ),
                },
                markers: Set<Marker>.of(m.markerList),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: m.markerListData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      getPolyPoints(
                          m.markerListData[index].geometry.location.lat,
                          m.markerListData[index].geometry.location.lng);
                    },
                    title: Text(
                      '${m.markerListData[index].name} (${calculateDistance(currentLocation!.latitude, currentLocation!.longitude, m.markerListData[index].geometry.location.lat, m.markerListData[index].geometry.location.lng).toStringAsFixed(2)}KM)',
                    ),
                    subtitle: Text(m.markerListData[index].vicinity),
                    trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 20.h,
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4.2.w),
                                      child: const Text('Direction'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        launchGoogleMaps(
                                            m.markerListData[index].geometry
                                                .location.lat,
                                            m.markerListData[index].geometry
                                                .location.lng);
                                      },
                                      child: const Text('Google Maps'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        launchWaze(
                                            m.markerListData[index].geometry
                                                .location.lat,
                                            m.markerListData[index].geometry
                                                .location.lng);
                                      },
                                      child: const Text('Waze'),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(PhosphorIcons.mapPin),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
