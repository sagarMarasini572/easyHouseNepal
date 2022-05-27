// importing required packages
import 'dart:convert';
import 'dart:io';

import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/model/user.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// creating LoginController class and extending GetxController
class ProfileController extends GetxController {
  bool isEditing = false;
  bool isLoading = false;
  User user = User.fromJson({
    'user_id': "",
    'email': "",
    'full_name': "",
    'contact': "",
    'role': "",
    'profile_image': "",
    'is_verified': false,
  });

  // Getting value from TextField Widget
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  File? imageFile;

  // Called immediately after the widget is allocated in memory.
  @override
  void onInit() {
    // calling getUser function
    getUser();
  }

  // declearing getUser function
  getUser() async {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    this.user = user;

    fullNameController.text = user.fullName!;
    emailController.text = user.email!;
    contactController.text = user.contact!;
    update();
  }

  // method to change edit Status function
  changeEditStatus() {
    isEditing = !isEditing;
    update();
  }

  // declearing pickImage function
  pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      uploadProfilePic();
    }
  }

  // declearing upload profilepic function
  uploadProfilePic() async {
    isLoading = true;
    update(['isLoading']);
    var url = Uri.parse(baseUrl + 'edit_user_profile_pic.php');
    var request = http.MultipartRequest("POST", url);
    request.fields["userId"] = user.userId!;
    if (imageFile != null) {
      var pic = await http.MultipartFile.fromPath("image", imageFile!.path);
      //add multipart to request
      request.files.add(pic);
    }
    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();
    var res = json.decode(resp);
    // checking for response
    if (res["success"]) {
      user.profileImage = res["data"];
      await SharedPrefs().storeUser(json.encode(user));
      // showing sucess message through snackbar
      customSnackbar('Success', res["message"][0], 'success');
    } else {
      // showing failed message through snackbar
      customSnackbar('Failed', res["message"][0], 'error');
    }

    isLoading = false;
    // updating users
    update();
  }

  // declearing editUser function
  editUser() async {
    isLoading = true;
    update(['isLoading']);
    // send  data using http post to our php code
    var response = await http.post(Uri.parse(baseUrl + 'edit_user.php'), body: {
      'userId': user.userId!,
      'full_name': fullNameController.text,
      'email': emailController.text,
      'contact': contactController.text,
    });

    //getting server response into variable
    var res = await json.decode(response.body);
    // checking for response
    if (res["success"]) {
      user.fullName = fullNameController.text;
      user.email = emailController.text;
      user.contact = contactController.text;
      // storing user data locally
      await SharedPrefs().storeUser(json.encode(user));
      // Finds a Instance of the required Class
      final HomeController homeController = Get.find();
      homeController.getUser();
      homeController.update();
      // showing sucess message through snackbar
      customSnackbar('Success', res["message"][0], 'success');
    } else {
      // showing failed message through snackbar
      customSnackbar('Failed', res["message"][0], 'error');
    }
    isLoading = false;
    // updating users
    update();
  }
}
