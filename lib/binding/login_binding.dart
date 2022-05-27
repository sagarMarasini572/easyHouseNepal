// importing required libraries
import 'package:easy_house_nepal/controllers/login_controller.dart';
import 'package:get/get.dart';

// defining LoginBinding
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    Get.put(LoginController());
  }
}
