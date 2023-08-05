import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pumpit/constant/color.dart';
import 'package:pumpit/controller/geolocator_controller.dart';
import 'package:pumpit/controller/home_controller.dart';
import 'package:pumpit/screen/chart/chart_screen.dart';
import 'package:pumpit/screen/main/main_screen.dart';
import 'package:pumpit/screen/profile/profile_screen.dart';
import 'package:pumpit/screen/setting/setting_screen.dart';
import 'package:pumpit/service/geolocator_service.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  HomeController h = Get.find();
  GeoLocatorController g = Get.find();

  final List<NavItem> _navItems = [
    NavItem(Icons.home, "Home"),
    NavItem(Icons.bar_chart, "Chart"),
    NavItem(Icons.people, "Profile"),
    NavItem(Icons.settings, "Setting"),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      h.changeTabIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          setState(() {
            g.isLoading = true;
          });

          await GeoLocatorService().determinePosition().then((value) {
            g.setLatLng(value);
            setState(() {
              g.isLoading = false;
            });

            print(g.lat);
            print(g.lng);
          }).then((value) => Get.toNamed('/map'));
        },
        child: g.isLoading
            ? const CircularProgressIndicator()
            : const Icon(
                PhosphorIcons.gasPump,
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _navItems.map((item) {
            var index = _navItems.indexOf(item);
            return IconButton(
              onPressed: () => _onNavItemTapped(index),
              icon: Icon(
                item.icon,
                color: h.tabIndex == index ? defaultColor : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ),
      body: IndexedStack(
        index: h.tabIndex,
        children: const [
          MainScreen(),
          ChartScreen(),
          ProfileScreen(),
          SettingScreen(),
        ],
      ),
    );
  }
}

class NavItem {
  IconData icon;
  String title;

  NavItem(this.icon, this.title);
}
