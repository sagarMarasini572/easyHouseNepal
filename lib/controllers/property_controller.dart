// importing required packages
import 'dart:convert';

import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// creating PropertyController class and extending GetxController  with GetTickerProviderStateMixin
class PropertyController extends GetxController
    with GetTickerProviderStateMixin {
  // defining tabController
  late TabController tabController;

  // Getting value from TextField Widget
  TextEditingController propertyNameController = TextEditingController();
  TextEditingController propertyPriceController = TextEditingController();
  TextEditingController propertyAreaController = TextEditingController();
  TextEditingController propertyAgeController = TextEditingController();
  TextEditingController propertyFloorController = TextEditingController();
  TextEditingController propertyRoomNoController = TextEditingController();
  TextEditingController propertyBedroomsNoController = TextEditingController();
  TextEditingController propertyBathroomsNoController = TextEditingController();
  TextEditingController propertyKitchenNoController = TextEditingController();
  TextEditingController propertyDistrictController = TextEditingController();
  TextEditingController propertyCityController = TextEditingController();
  TextEditingController propertyToleController = TextEditingController();
  TextEditingController propertyHouseNoController = TextEditingController();
  TextEditingController propertyDescriptionController = TextEditingController();
  TextEditingController propertyFullNameController = TextEditingController();
  TextEditingController propertyEmailController = TextEditingController();
  TextEditingController propertyContactNoController = TextEditingController();


  // initalizing default values
  String facingDirection = 'East';
  String contractDuaration = '3 Months';
  String province = 'Province 1';

  bool isLoading = false;
  String propertyId = '';
  String categoryId = '';
  List<Images> images = [];

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  // Called immediately after the widget is allocated in memory.
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 5);
  }

  
  

  // method to change facing Direction
  changeFacingDirection(direction) {
    facingDirection = direction;
    update();
  }

  // method to change Contract Duration
  changeContractDuaration(direction) {
    contractDuaration = direction;
    update();
  }

  // method to change Province
  changeProvince(pro) {
    province = pro;
    update();
  }

  Future<void> pickImages() async {
    try {
      //you can use ImageCourse.camera for Camera capture
      var pickedfiles = await imgpicker.pickMultiImage();
      // image is selected
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        update();
      } else {
        // showing error message
        customSnackbar('Error', 'No Images selected', 'error');
      }
    } catch (e) {
      // showing error message
      customSnackbar('Error', 'Something went wrong!', 'error');
    }
  }

  // Function to Check House Upload
  void checkHouseUpload(propertyId) {
    // Checking if property name field is empty
    if (propertyNameController.text.isEmpty) {
      // showing error message
      customSnackbar('Property Name *', 'Please enter property name', 'error');
      tabController.animateTo(0);
      // Checking if property price field is empty
    } else if (propertyPriceController.text.isEmpty) {
      // showing error message
      customSnackbar(
          'Property Price *', 'Please enter property price', 'error');
      tabController.animateTo(0);
      // Checking if property area field is empty
    } else if (propertyAreaController.text.isEmpty) {
      // showing error message
      customSnackbar('Property Area *', 'Please enter property area', 'error');
      tabController.animateTo(0);
      // Checking if property age field is empty
    } else if (propertyAgeController.text.isEmpty) {
      // showing error message
      customSnackbar('Building Age *', 'Please enter property age', 'error');
      tabController.animateTo(0);
      // Checking if property floor field is empty
    } else if (propertyFloorController.text.isEmpty) {
      // showing error message
      customSnackbar('No. Of Floors *', 'Please enter property floor', 'error');
      tabController.animateTo(0);
      // Checking if property room no field is empty
    } else if (propertyRoomNoController.text.isEmpty) {
      // showing error message
      customSnackbar('No. Of Rooms', 'Please enter property room no', 'error');
      tabController.animateTo(0);
      // Checking if property bedrooms field is empty
    } else if (propertyBedroomsNoController.text.isEmpty) {
      // showing error message
      customSnackbar(
          'No. Of BedRooms *', 'Please enter property bedrooms no', 'error');
      tabController.animateTo(0);
      // Checking if property bathrooms field is empty
    } else if (propertyBathroomsNoController.text.isEmpty) {
      // showing error message
      customSnackbar(
          'No. Of BathRooms *', 'Please enter property bathrooms no', 'error');
      tabController.animateTo(0);
      // Checking if property kitchen no field is empty
    } else if (propertyKitchenNoController.text.isEmpty) {
      // showing error message
      customSnackbar(
          'No. Of Kitchen *', 'Please enter property kitchen no', 'error');
      tabController.animateTo(0);
      // Checking if property image field is empty
    } else if (propertyId == null && imagefiles == null) {
      // showing error message
      customSnackbar('Images *', 'Please provide property images', 'error');
      tabController.animateTo(1);
      // Checking if property district field is empty
    } else if (propertyDistrictController.text.isEmpty) {
      // showing error message
      customSnackbar('District *', 'Please enter property district', 'error');
      tabController.animateTo(2);
      // Checking if property city field is empty
    } else if (propertyCityController.text.isEmpty) {
      // showing error message
      customSnackbar('City *', 'Please enter property city', 'error');
      tabController.animateTo(2);
      // Checking if property tole field is empty
    } else if (propertyToleController.text.isEmpty) {
      // showing error message
      customSnackbar('Tole *', 'Please enter property tole', 'error');
      tabController.animateTo(2);
      // Checking if property house no field is empty
    } else if (propertyHouseNoController.text.isEmpty) {
      // showing error message
      customSnackbar('House No. *', 'Please enter property house no', 'error');
      tabController.animateTo(2);
      // Checking if property description field is empty
    } else if (propertyDescriptionController.text.isEmpty) {
      // showing error message
      customSnackbar('Property Description *',
          'Please enter property description', 'error');
      tabController.animateTo(3);
      // Checking if property owner full name field is empty
    } else if (propertyFullNameController.text.isEmpty) {
      // showing error message
      customSnackbar('Full Name *', 'Please enter owner full name', 'error');
      // Checking if property owner email field is empty
    } else if (propertyEmailController.text.isEmpty) {
      // showing error message
      customSnackbar('Email *', 'Please enter owner email', 'error');
      // Checking if property owner contact no field is empty
    } else if (propertyContactNoController.text.isEmpty) {
      // showing error message
      customSnackbar('Contact No. *', 'Please enter owner contact no', 'error');
    } else {
      // selse adding property
      addProperty(propertyId);
    }
  }

  // Function to Check House Upload
  void addProperty(propertyId) async {
    isLoading = true;
    update();
    var url = Uri.parse(baseUrl + 'property/addProperty.php');
    var request = http.MultipartRequest("POST", url);
    if (imagefiles != null) {
      for (var element in imagefiles!) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      }
    }
    if (propertyId != null) {
      request.fields['property_id'] = propertyId;
    }
    request.fields['property_title'] = propertyNameController.text;
    request.fields['property_price'] = propertyPriceController.text;
    request.fields['property_area'] = propertyAreaController.text;
    request.fields['property_age'] = propertyAgeController.text;
    request.fields['no_of_floors'] = propertyFloorController.text;
    request.fields['no_of_rooms'] = propertyRoomNoController.text;
    request.fields['facing_direction'] = facingDirection;
    request.fields['contract_duration'] = contractDuaration;
    request.fields['no_of_bedrooms'] = propertyBedroomsNoController.text;
    request.fields['no_of_bathrooms'] = propertyBathroomsNoController.text;
    request.fields['no_of_kitchens'] = propertyKitchenNoController.text;
    request.fields['province'] = province;
    request.fields['district'] = propertyDistrictController.text;
    request.fields['city'] = propertyCityController.text;
    request.fields['tole'] = propertyToleController.text;
    request.fields['property_house_no'] = propertyHouseNoController.text;
    request.fields['property_description'] = propertyDescriptionController.text;
    request.fields['owner_name'] = propertyFullNameController.text;
    request.fields['owner_email'] = propertyEmailController.text;
    request.fields['owner_contact'] = propertyContactNoController.text;

    var response = await request.send();

    var resp = await response.stream.transform(utf8.decoder).join();

    var res = json.decode(resp);

    if (res['success']) {
      HomeController homeController = Get.find();
      homeController.fetchAllProperties();
      Get.offNamed(GetRoutes.home);
      customSnackbar('Success', res['message'][0], 'success');
    } else {
      customSnackbar('Error', res['message'][0], 'error');
    }
    isLoading = false;
    // resetText();12345
    update();
  }

  resetText() {
    propertyId = "";
    propertyNameController.text = "";
    propertyPriceController.text = "";
    propertyAreaController.text = "";
    propertyAgeController.text = "";
    propertyFloorController.text = "";
    propertyRoomNoController.text = "";
    propertyBedroomsNoController.text = "";
    propertyBathroomsNoController.text = "";
    propertyKitchenNoController.text = "";
    propertyDistrictController.text = "";
    propertyCityController.text = "";
    propertyToleController.text = "";
    propertyHouseNoController.text = "";
    propertyDescriptionController.text = "";
    propertyFullNameController.text = "";
    propertyEmailController.text = "";
    propertyContactNoController.text = "";
    facingDirection = "East";
    contractDuaration = "3 Months";
    province = "Province 1";
    images = [];
    update();
  }

  editProperty(Property property) async {
    propertyId = property.propertyId!;
    propertyNameController.text = property.propertyTitle!;
    propertyPriceController.text = property.propertyPrice!;
    propertyAreaController.text = property.propertyArea!;
    propertyAgeController.text = property.propertyAge!;
    propertyFloorController.text = property.noOfFloors!;
    propertyRoomNoController.text = property.noOfRooms!;
    propertyBedroomsNoController.text = property.noOfBedrooms!;
    propertyBathroomsNoController.text = property.noOfBathrooms!;
    propertyKitchenNoController.text = property.noOfKitchens!;
    propertyDistrictController.text = property.district!;
    propertyCityController.text = property.city!;
    propertyToleController.text = property.tole!;
    propertyHouseNoController.text = property.propertyHouseNo!;
    propertyDescriptionController.text = property.propertyDescription!;
    propertyFullNameController.text = property.ownerName!;
    propertyEmailController.text = property.ownerEmail!;
    propertyContactNoController.text = property.ownerContact!;
    facingDirection = property.facingDirection!;
    contractDuaration = property.contractDuration!;
    province = property.province!;
    images = property.images!;
    update();
  }
}
