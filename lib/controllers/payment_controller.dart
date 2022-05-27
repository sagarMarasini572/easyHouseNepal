// importing required packages
import 'dart:convert';

import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// creating PaymentController class and extending GetxController
class PaymentController extends GetxController {
  void makeBookings(Property p, token) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    // send  data using http post to our php code
    var response = await http
        .post(Uri.parse(baseUrl + 'property/book_property.php'), body: {
      //json maping user entered details
      'property_id': p.propertyId,
      'user_id': user.userId,
      'token': token
    });
    //getting server response into variable
    var res = await jsonDecode(response.body);
    // checking for response
    if (res['success']) {
      // showing sucess message through snackbar
      customSnackbar('Success', res['message'][0], 'success');
      // Finds a Instance of the required Class
      final HomeController homeController = Get.find();
      homeController.fetchAllProperties();
      homeController.update();
    } else {
      // showing failed message through snackbar
      customSnackbar('Error', res['message'][0], 'error');
    }
    // navigating to home screen
    Get.toNamed(GetRoutes.home);
  }
}
