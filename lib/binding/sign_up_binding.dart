// importing required libraries
import 'package:easy_house_nepal/controllers/signup_controller.dart';
import 'package:get/get.dart';

// defining SignUpBinding
class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    Get.put(SignupController());
  }
}
