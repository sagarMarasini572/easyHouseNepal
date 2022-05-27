// importing required libraries
import 'package:easy_house_nepal/controllers/default_controller.dart';
import 'package:easy_house_nepal/controllers/verify_controller.dart';
import 'package:get/get.dart';

// defining WelcomeBinding
class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    Get.put(DefaultController());
    Get.put(VerifyController());
  }
}
