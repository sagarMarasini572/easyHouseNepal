// importing required libraries
import 'dart:convert';

import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// creating HomeController class and extending GetxController
class HomeController extends GetxController {
  List<Property> properties = [];
  List<Property> filteredProperties = [];

  User user = User();

  bool isLoading = false;

  // Called immediately after the widget is allocated in memory.
  @override
  void onInit() {
    super.onInit();
    getUser();
    fetchAllProperties();
  }

  // defining async getUser function
  getUser() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    this.user = user;
    update();
  }

  // defining async function to fetch all properties
  fetchAllProperties() async {
    isLoading = true;
    update(['isLoading']);
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    // send  data using http post to our php code
    var response =
        await http.post(Uri.parse(baseUrl + '/property/properties.php'), body: {
      //json maping user entered details
      'user_id': user.userId.toString(),
    });
    //getting server response into variable
    var res = await jsonDecode(response.body);
    // checking for response
    if (res['success']) {
      filteredProperties = Properties.fromJson(res).properties!;
      properties = Properties.fromJson(res).properties!;
    } else {
      properties = [];
      filteredProperties = [];
    }
    isLoading = false;
    update();
  }

  // defining search function
  search(String val) {
    // if val is empty
    if (val.isNotEmpty) {
      // fileter properties on the basic of province
      filteredProperties = properties
          .where((prty) =>
              prty.province!.toLowerCase().contains(val.toLowerCase()) ||
              prty.propertyTitle!.toLowerCase().contains(val.toLowerCase()) ||
              prty.district!.toLowerCase().contains(val.toLowerCase()) ||
              prty.city!.toLowerCase().contains(val.toLowerCase()) ||
              prty.propertyPrice!.contains(val.toLowerCase()))
          .toList();
    } else {
      filteredProperties = properties;
    }
    update();
  }

  // define asynce function to add property to wishlist
  addToWishList(propertyId) async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    // send  data using http post to our php code
    var response = await http
        .post(Uri.parse(baseUrl + 'property/add_to_wishlist.php'), body: {
      //json maping user entered details
      'user_id': user.userId,
      'property_id': propertyId,
    });
    //getting server response into variable
    var res = await jsonDecode(response.body);
    // checking for response
    if (res['success']) {
      customSnackbar('Success', res['message'][0], 'success');
      // fetching all properties
      fetchAllProperties();
      // updating properties
      update();
      return true;
    } else {
      // showing erroe message through snackbar
      customSnackbar('Error', res['message'][0], 'error');
      return false;
    }
  }
}
