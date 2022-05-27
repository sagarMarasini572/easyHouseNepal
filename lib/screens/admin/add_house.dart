import 'dart:io';

import 'package:easy_house_nepal/controllers/property_controller.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:easy_house_nepal/widgets/custom_dropdown.dart';
import 'package:easy_house_nepal/widgets/custom_textform_full.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHouse extends StatelessWidget {
  AddHouse({Key? key}) : super(key: key);

  final isEdit = Get.arguments ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit House' : 'Add House'),
      ),
      drawer: isEdit ? null : const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: GetBuilder<PropertyController>(
          builder: (controller) {
            return TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const BasicInformation(),
                MediaInformation(
                  isEdit: isEdit,
                ),
                const LocationInformation(),
                const PropertyDescInformation(),
                ContactInformation(
                  isEdit: isEdit,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BasicInformation extends StatelessWidget {
  const BasicInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertyController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              child: const Text(
                'Basic Information',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
           
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Property Name *',
              hint: 'Please enter property name',
              controller: controller.propertyNameController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Property price (/month) *',
              hint: 'Please enter property price per month',
              controller: controller.propertyPriceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Property Area (.sq.m) *',
              hint: 'Please enter property area',
              controller: controller.propertyAreaController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Building Age *',
              hint: 'Please enter building age',
              keyboardType: TextInputType.number,
              controller: controller.propertyAgeController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'No of Floors *',
              hint: 'Please enter no. of floors',
              keyboardType: TextInputType.number,
              controller: controller.propertyFloorController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'No of Rooms *',
              hint: 'Please enter no. of rooms',
              keyboardType: TextInputType.number,
              controller: controller.propertyRoomNoController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomDropdown(
              title: 'Facing Direction (mohoda) *',
              dropdownItems: const ['East', 'West', 'North', 'South'],
              onChanged: (val) {
                controller.changeFacingDirection(val);
              },
              selected: controller.facingDirection,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomDropdown(
              title: 'Contract Duration *',
              dropdownItems: const [
                '3 Months',
                '6 Months',
                '1 years',
                '1+ Years'
              ],
              onChanged: (val) {
                controller.changeContractDuaration(val);
              },
              selected: controller.contractDuaration,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'No. of Bed Rooms*',
              hint: 'Please enter no. of bed rooms.',
              keyboardType: TextInputType.number,
              controller: controller.propertyBedroomsNoController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'No. of Bath Rooms*',
              hint: 'Please enter no. of bath rooms.',
              keyboardType: TextInputType.number,
              controller: controller.propertyBathroomsNoController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'No. of Kitchens Rooms*',
              hint: 'Please enter no. of Kitchens rooms.',
              keyboardType: TextInputType.number,
              controller: controller.propertyKitchenNoController,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              title: 'Next',
              onPressed: () {
                controller.tabController.animateTo(1);
              },
            )
          ],
        ),
      );
    });
  }
}

class MediaInformation extends StatelessWidget {
  const MediaInformation({Key? key, this.isEdit = false}) : super(key: key);
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertyController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            child: const Text(
              'Media Information',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              controller.pickImages();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.blue,
              child: const Text(
                'Pick Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (isEdit)
            Wrap(
                children: controller.images.map((imageone) {
              return Card(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: NetworkImage(baseUrl + imageone.imgPath!),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList()),
          controller.imagefiles != null
              ? Wrap(
                  children: controller.imagefiles!.map((imageone) {
                  return Card(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.file(File(imageone.path), fit: BoxFit.cover),
                    ),
                  );
                }).toList())
              : Container(),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      title: 'Previous',
                      onPressed: () {
                        controller.tabController.animateTo(0);
                      })),
              const SizedBox(width: 10),
              Expanded(
                  child: CustomButton(
                      title: 'Next',
                      onPressed: () {
                        controller.tabController.animateTo(2);
                      })),
            ],
          )
        ]),
      );
    });
  }
}

class LocationInformation extends StatelessWidget {
  const LocationInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<PropertyController>(builder: (controller) {
        return Column(children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 230, 230, 230),
            ),
            child: const Text(
              'Location Information',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormFieldFull(
            title: 'House No *',
            hint: 'Please enter property name',
            controller: controller.propertyHouseNoController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormFieldFull(
            title: 'Tole *',
            hint: 'Please enter property name',
            controller: controller.propertyToleController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormFieldFull(
            title: 'City *',
            hint: 'Please enter property name',
            controller: controller.propertyCityController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDropdown(
            title: 'Province *',
            dropdownItems: const [
              'Province 1',
              'Madesh',
              'Bagmati',
              'Gandaki',
              'Lumbini',
              'Karnali',
              'Sudurpachim'
            ],
            onChanged: (val) {
              controller.changeProvince(val);
            },
            selected: controller.province,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormFieldFull(
            title: 'District *',
            hint: 'Please enter property name',
            controller: controller.propertyDistrictController,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      title: 'Previous',
                      onPressed: () {
                        controller.tabController.animateTo(1);
                      })),
              const SizedBox(width: 10),
              Expanded(
                  child: CustomButton(
                      title: 'Next',
                      onPressed: () {
                        controller.tabController.animateTo(3);
                      })),
            ],
          ),
        ]);
      }),
    );
  }
}

class PropertyDescInformation extends StatelessWidget {
  const PropertyDescInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertyController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              child: const Text(
                'Property Description',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0x1d15563c),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextFormField(
                maxLines: 7,
                controller: controller.propertyDescriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please enter property description',
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        title: 'Previous',
                        onPressed: () {
                          controller.tabController.animateTo(2);
                        })),
                const SizedBox(width: 10),
                Expanded(
                    child: CustomButton(
                        title: 'Next',
                        onPressed: () {
                          controller.tabController.animateTo(4);
                        })),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      );
    });
  }
}

class ContactInformation extends StatelessWidget {
  const ContactInformation({Key? key, this.isEdit = false}) : super(key: key);
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PropertyController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 230, 230, 230),
              ),
              child: const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Full Name *',
              hint: 'Please enter full name',
              controller: controller.propertyFullNameController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Email *',
              hint: 'Please enter email',
              controller: controller.propertyEmailController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormFieldFull(
              title: 'Contact No. *',
              hint: 'Please enter contact number',
              keyboardType: TextInputType.number,
              controller: controller.propertyContactNoController,
            ),
            const SizedBox(
              height: 30,
            ),
            !controller.isLoading
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Previous',
                          onPressed: () {
                            controller.tabController.animateTo(3);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          title: 'Submit',
                          onPressed: () {
                            controller.checkHouseUpload(
                                isEdit ? controller.propertyId : null);
                          },
                        ),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
