// importing required libraries
import 'dart:convert';

import 'package:easy_house_nepal/model/all_user_booking.dart';
import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// creating HomeController class and extending GetxController
class AllUserBookingController extends GetxController {
  List<AllUserBooking> allUserBooking = [];

  User user = User();

  bool isLoading = false;

  // Called immediately after the widget is allocated in memory.
  @override
  void onInit() {
    super.onInit();
    getUser();
    fetchAllUserBookings();
  }

  // defining async getUser function
  getUser() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    this.user = user;
    update();
  }

  // defining async function to fetch all properties
  fetchAllUserBookings() async {
    isLoading = true;
    update(['isLoading']);
    // send  data using http post to our php code
    var response = await http.get(
      Uri.parse(baseUrl + '/user_bookings.php'),
    );
    //getting server response into variable
    var res = await jsonDecode(response.body);
    // checking for response
    if (res['success']) {
      allUserBooking = AllUserBookings.fromJson(res).allUserBooking!;
    } else {
      allUserBooking = [];
    }
    isLoading = false;
    update();
  }
}
