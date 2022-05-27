// importing required libraries
import 'dart:convert';

import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// creating ChangePasswordController class and extending GetxController
class ChangePasswordController extends GetxController {
  // Getting value from TextField Widget
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordObscureText = true;
  bool isNewPasswordObscureText = true;
  bool isConfirmNewPasswordObscureText = true;

  // define async change password function
  changePassword() async {
    // checking if password field is empty
    if (oldPasswordController.text.isEmpty) {
      // showing error message
      customSnackbar('Error', 'Password required', 'error');
      // checking if password field  or confirm new password field is empty
    } else if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      // showing error message
      customSnackbar('Error', 'New Password required', 'error');
      // checking if password field and confirm password fiels matched
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      // showing error message
      customSnackbar('Error', 'Password doesnot match!', 'error');
    } else {
      var usr = await SharedPrefs().getUser();
      User user = User.fromJson(json.decode(usr));
      isLoading = true;
      update(['isLoading']);

      //starting login API Call
      var response =
          await http.post(Uri.parse(baseUrl + 'change_password.php'), body: {
        // Store all data with Parm Name.
        'user_id': user.userId,
        'password': oldPasswordController.text,
        'new_password': newPasswordController.text,
      });

      //getting server response into variable
      var res = await jsonDecode(response.body);
      // if success equals true
      if (res['success'] == true) {
        // showing success message through snackbar
        customSnackbar('Password', res["message"][0], 'success');
        // navigating to home screen
        Get.offAllNamed(GetRoutes.home);
      } else {
        // showing login failed message through snackbar
        customSnackbar('Error', res["message"][0], 'error');
      }
      isLoading = false;
      // updating users
      update();
    }
  }
}
