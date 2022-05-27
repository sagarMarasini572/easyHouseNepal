// importing required libraries
import 'package:easy_house_nepal/controllers/all_user_boookings_controller.dart';
import 'package:get/get.dart';

// defining AllUserBookingBinding
class AllUserBookingBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    Get.put(AllUserBookingController());
  }
}
