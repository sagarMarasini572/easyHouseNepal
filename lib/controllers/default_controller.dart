// importing required packages
import 'dart:convert';

import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:get/get.dart';

// creating DefaultControlle class and extending GetxController
class DefaultController extends GetxController {
  
  // Called immediately after the widget is allocated in memory.
  @override
  void onInit() {
    super.onInit();
    checkUserLogin();
  }

  // defining async check User Login function
  checkUserLogin() async {
    var usr = await SharedPrefs().getUser();
    if (usr != null) {
      User user = User.fromJson(json.decode(usr));
      if (user.isVerified!) {
        // navigating to home screen
        Get.offAllNamed(GetRoutes.home);
      } else {
        // navigating to verify screen
        Get.offAllNamed(GetRoutes.verify);
      }
    }
  }
}
