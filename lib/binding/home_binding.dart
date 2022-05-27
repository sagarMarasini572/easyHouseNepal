// importing required libraries
import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/controllers/payment_controller.dart';
import 'package:easy_house_nepal/controllers/profile_controller.dart';
import 'package:easy_house_nepal/controllers/property_controller.dart';
import 'package:get/get.dart';

// defining HomeBinding
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there
    Get.put(HomeController());
    Get.put(PropertyController());
    Get.put(ProfileController());
    Get.put(PaymentController());
    // Get.put(MyTabController());
  }
}
