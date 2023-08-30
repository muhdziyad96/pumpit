import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pumpit/controller/profile_controller.dart';
import 'package:pumpit/helper/sql_helper.dart';
import 'package:pumpit/model/user_model.dart';
import 'package:pumpit/util/preference.dart';
import 'package:sqflite/sqflite.dart';

class UserController extends GetxController {
  var userData = User().obs;

  void setUserData(Rx<User> userData) {
    this.userData = userData;
    update();
  }

  Future<void> loginUsers(String phone) async {
    Database db = await DatabaseHelper.instance.database;
    var user = await db.query(
      'users', where: 'phone = ?', // WHERE clause
      whereArgs: [phone], limit: 1,
    );

    userData.value = User.fromMap(user[0]);
    Preference.setString(Preference.userId, userData.value.id!.toString());
    Preference.setBool(Preference.isLogin, true);
    setUserData(userData);
    ProfileController p = Get.put(ProfileController());
    p.getTextController(
        name: userData.value.name ?? 'Not Set',
        email: userData.value.email ?? 'Not Set',
        gender: userData.value.gender ?? 'Not Set');
    p.getIcon(
        image: userData.value.image ?? PhosphorIcons.cat.codePoint.toString());
    update();
  }

  Future<void> getUsers() async {
    String? userId = Preference.getString(Preference.userId);
    Database db = await DatabaseHelper.instance.database;
    var user = await db.query(
      'users', where: 'id = ?', // WHERE clause
      whereArgs: [userId], limit: 1,
    );

    print(user);
    userData.value = User.fromMap(user[0]);
    Preference.setString(Preference.userId, userData.value.id!.toString());
    setUserData(userData);
    ProfileController p = Get.put(ProfileController());
    p.getTextController(
        name: userData.value.name ?? 'Not Set',
        email: userData.value.email ?? 'Not Set',
        gender: userData.value.gender ?? 'Not Set');
    p.getIcon(
        image: userData.value.image ?? PhosphorIcons.cat.codePoint.toString());
    update();
  }
}
