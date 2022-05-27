// importing required packages
import 'dart:convert';

import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

// creating LoginController class and extending GetxController
class LoginController extends GetxController {
  // Getting value from TextField Widget
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  // For Hiding Password
  bool isPasswordObscureText = true;

  // Function to Check Login
  checkLogin() {
    // Checking if Email field is empty
    if (emailController.text.isEmpty) {
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
      // login if all parameters are correct
    } else {
      // calling user login function
      userLogin();
    }
  }

  // Function for user Login
  userLogin() async {
    isLoading = true;
    update();
    //starting login API Call
    var response = await http.post(Uri.parse(baseUrl + 'login.php'), body: {
      // Store all data with Parm Name.
      'email': emailController.text,
      'password': passwordController.text,
    });

    //getting server response into variable
    var res = await json.decode(response.body);
    // checking for response
    if (res["success"]) {
      // constructing a new user instance from a map structure
      User user = User.fromJson(res['data']);
      // storing user data locally
      await SharedPrefs().storeUser(json.encode(user));
      // chaecking data validity
      if (res["data"]["is_verified"]) {
        // navigating to home screen
        Get.toNamed(GetRoutes.home);
        // showing login success message through snackbar
        customSnackbar('Login Success', res['message'][0], 'success');
      } else {
        // navigating to verify screen
        Get.toNamed(GetRoutes.verify);
      }
    } else {
      // showing login failed message through snackbar
      customSnackbar('Login Failed', res['message'][0], 'error');
    }
    isLoading = false;
    // updating users
    update();
  }
}
