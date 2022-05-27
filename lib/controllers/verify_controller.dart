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

class VerifyController extends GetxController {
  // Getting value from TextField Widget
  TextEditingController verifyController = TextEditingController();
  TextEditingController resetCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  // For CircularProgressIndicator
  bool isLoading = false;
  // for resending OTP
  bool isResendLoading = false;
  // For Hiding NewPassword
  bool isNewPasswordObscureText = true;
  // For Hiding ConfirmNewPassword
  bool isConfirmNewPasswordObscureText = true;

  // Function for verifying user
  verify() async {
    // checking for empty text
    if (verifyController.text.isEmpty) {
      // showing error message
      customSnackbar('Error', 'Please enter OTP!', 'error');
      // checking if text is less than 6
    } else if (verifyController.text.length < 6) {
      // showing error message
      customSnackbar('Error', 'Please enter valid OTP!', 'error');
    } else {
      isLoading = true;
      update();
      var usr = await SharedPrefs().getUser();
      User user = User.fromJson(json.decode(usr));
      //starting login API Call
      var response =
          await http.post(Uri.parse(baseUrl + 'verify_user.php'), body: {
        // Store all data with Parm Name.
        'user_id': user.userId,
        'otp': verifyController.text,
      });

      //getting server response into variable
      var res = await jsonDecode(response.body);
      // checking for response
      if (res['success']) {
        // showing success message through snackbar
        customSnackbar('Success', res['message'][0], 'success');
        var usr = await SharedPrefs().getUser();
        // loading function
        User user = User.fromJson(json.decode(usr));
        user.isVerified = true;
        // storing user data locally
        await SharedPrefs().storeUser(json.encode(user.toJson()));
        // navigating to home screen
        Get.offAllNamed(GetRoutes.home);
      } else {
        // showing error message through snackbar
        customSnackbar('Error', res['message'][0], 'error');
      }
      isLoading = false;
      // updating users
      update();
    }
  }

  // creating resendCode function
  resendCode() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    // calling resendDynamic function
    resendDynamic(user.email, 'verify');
  }

  // creating resendForgetPassword function
  resendForgetPassword() async {
    // checking for empty text
    if (emailController.text.isEmpty) {
      // showing error message through snackbar
      customSnackbar('Error', 'Email address required', 'error');
      // validating email
    } else if (!GetUtils.isEmail(emailController.text)) {
      // showing error message through snackbar
      customSnackbar('Error', 'Valid email address required!', 'error');
    } else {
      // calling resendDynamic function
      resendDynamic(emailController.text, 'forget_password');
    }
  }

  // creating resendDynamic function and taking email, type as parameter
  resendDynamic(email, type) async {
    isResendLoading = true;
    update();
    //starting login API Call
    var response =
        await http.post(Uri.parse(baseUrl + 'resend_code.php'), body: {
      // Store all data with Parm Name.
      'email': email,
      'type': type,
    });
    //getting server response into variable
    var res = await jsonDecode(response.body);
    // checking for response
    if (res['success']) {
      if (type == 'forget_password') {
        // navigating to resetPassword screen
        Get.toNamed(GetRoutes.resetPassword);
      }
      // showing success message through snackbar
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      // showing error message through snackbar
      customSnackbar('Error', res['message'][0], 'error');
    }
    isResendLoading = false;
    // updating users
    update();
  }

  // creating resetPassword function
  resetPassword() async {
    // Checking if reset Code field is empty
    if (resetCodeController.text.isEmpty) {
      // showing error message through snackbar
      customSnackbar('Error', 'Reset Code is required!', 'error');
      // Checking if new password field or confirm password is empty
    } else if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      // showing error message through snackbar
      customSnackbar('Error', 'New Password required', 'error');
      // Checking if new password field and confirm password matched
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      // showing error message through snackbar
      customSnackbar('Error', 'Password doesnot match!', 'error');
    } else {
      isLoading = true;
      update();
      //starting reset+password API Call
      var response =
          await http.post(Uri.parse(baseUrl + 'reset_password.php'), body: {
        // Store all data with Parm Name.
        'password': newPasswordController.text,
        'code': resetCodeController.text,
        'email': emailController.text
      });
      //getting server response into variable
      var res = await jsonDecode(response.body);
      // checking for response
      if (res['success']) {
        // showing success message through snackbar
        customSnackbar('Success', res['message'][0], 'success');
        // navigating to login screen
        Get.offAllNamed(GetRoutes.login);
      } else {
        // showing error message through snackbar
        customSnackbar('Error', res['message'][0], 'error');
      }

      isLoading = false;
      // updating users
      update();
    }
  }
}
