// importing required libraries
import 'package:easy_house_nepal/controllers/change_password_controller.dart';
import 'package:get/get.dart';

// defining changePasswordBinding
class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    Get.put(ChangePasswordController());
  }
}
