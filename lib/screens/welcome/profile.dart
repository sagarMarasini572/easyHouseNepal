import 'package:easy_house_nepal/controllers/profile_controller.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:easy_house_nepal/widgets/custom_textform_full.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(builder: (controller) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Image(
                            fit: BoxFit.cover,
                            image: controller.user.profileImage == ''
                                ? NetworkImage(
                                    'https://ui-avatars.com/api/?background=random&name=' +
                                        controller.user.fullName!,
                                  )
                                : NetworkImage(
                                    baseUrl + controller.user.profileImage!,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
                          child: const FaIcon(
                            FontAwesomeIcons.camera,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  controller.user.fullName!,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    color: Color(0xfa209fa8),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormFieldFull(
                  title: 'Full Name',
                  hint: "Enter your full name",
                  readOnly: !controller.isEditing,
                  controller: controller.fullNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFieldFull(
                  title: 'Email',
                  hint: "Enter your email address",
                  readOnly: !controller.isEditing,
                  controller: controller.emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormFieldFull(
                  title: 'Contact',
                  hint: "Enter your contact number",
                  readOnly: !controller.isEditing,
                  controller: controller.contactController,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (controller.isEditing)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Save',
                          onPressed: () {
                            Get.back();
                            Get.back();
                            controller.editUser();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomButton(
                          title: 'Cancel',
                          bgColor: Colors.red,
                          onPressed: () {
                            controller.changeEditStatus();
                          },
                        ),
                      ),
                    ],
                  )
                else
                  CustomButton(
                      title: 'Edit',
                      onPressed: () {
                        controller.changeEditStatus();
                      }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
