// importing required libraries
import 'package:easy_house_nepal/controllers/user_controller.dart';
import 'package:get/get.dart';

// defining UserBinding
class UserBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    Get.put(UserController());
  }
}
