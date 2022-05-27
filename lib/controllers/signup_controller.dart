// importing required packages
import 'dart:convert';

import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// creating SignupController class and extending GetxController
class SignupController extends GetxController {
  // Getting value from TextField Widget
  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // For Hiding Password
  bool isPasswordObscure = true;
  // For Hiding ConfirmPassword
  bool isConfirmPasswordObscure = true;
  // For CircularProgressIndicator
  bool isLoading = false;

  // Function to Check Signup
  checkSignup() {
    // Checking if fullName field is empty
    if (fullNameController.text.isEmpty) {
      // showing error message
      customSnackbar('*FullName', 'Please enter your email.', 'error');
    } else if (contactController.text.isEmpty) {
      // showing error message
      customSnackbar('*Contact', 'Please enter your email.', 'error');
      // Checking if Email field is empty
    } else if (emailController.text.isEmpty) {
      // showing error message
      customSnackbar('*Email', 'Please enter your email.', 'error');
      // checking regs of Email
    } else if (GetUtils.isEmail(emailController.text) == false) {
      // showing error message
      customSnackbar('*Email', 'Please enter valid email', 'error');
      // checking if password field is empty
    } else if (passwordController.text.isEmpty) {
      // showing error message
      customSnackbar('*Password', 'Please enter password', 'error');
      // checking if confirm password field is empty
    } else if (confirmPasswordController.text.isEmpty) {
      // showing error message
      customSnackbar('*Password', 'Please enter password', 'error');
      // checking if password field and confirm password field matches
    } else if (confirmPasswordController.text != passwordController.text) {
      // showing error message
      customSnackbar('*Password', 'Please enter password', 'error');
    } else {
      // calling user Signup function
      userSignup();
    }
  }

  // Function for user Signup
  userSignup() async {
    isLoading = true;
    update(['isLoading']);
    //send  data using http post to our php code
    var response = await http.post(Uri.parse(baseUrl + 'signup.php'),
        //json maping user entered details
        body: {
          'full_name': fullNameController.text,
          'email': emailController.text,
          'contact': contactController.text,
          'password': passwordController.text,
        });

    // getting response from php code, here
    var res = await json.decode(response.body);
    // checking for response
    if (res["success"]) {
      // constructing a new user instance from a map structure
      User user = User.fromJson(res['data']);
      // storing user data locally
      await SharedPrefs().storeUser(json.encode(user));
      // navigating to verify screen
      Get.offAllNamed(GetRoutes.verify);
      // showing Sign up success message through snackbar
      customSnackbar('Sign up Success', res['message'][0], 'success');
    } else {
      // showing Sign up failed message through snackbar
      customSnackbar('Sign up Failed', res['message'][0], 'error');
    }
  }
}
