import 'package:easy_house_nepal/controllers/change_password_controller.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:easy_house_nepal/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final changePasswordController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: InkWell(
              onTap: () => Get.back(),
              child: const FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
                  GetBuilder<ChangePasswordController>(builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'Enter you old password',
                      label: 'Old Password',
                      icon: FontAwesomeIcons.userLock,
                      obscureText: controller.isPasswordObscureText,
                      isPassword: true,
                      controller: controller.oldPasswordController,
                      onPasswordToggle: () {
                        controller.isPasswordObscureText =
                            !controller.isPasswordObscureText;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'Enter new password',
                      label: 'New Password',
                      icon: FontAwesomeIcons.userLock,
                      obscureText: controller.isNewPasswordObscureText,
                      isPassword: true,
                      controller: controller.newPasswordController,
                      onPasswordToggle: () {
                        controller.isNewPasswordObscureText =
                            !controller.isNewPasswordObscureText;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'Confirm new password',
                      label: 'Re-enter New Password',
                      icon: FontAwesomeIcons.userLock,
                      obscureText: controller.isConfirmNewPasswordObscureText,
                      isPassword: true,
                      controller: controller.confirmNewPasswordController,
                      onPasswordToggle: () {
                        controller.isConfirmNewPasswordObscureText =
                            !controller.isConfirmNewPasswordObscureText;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 30),
                    controller.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: 'Change Password',
                            onPressed: () {
                              controller.changePassword();
                            }),
                    const SizedBox(height: 30),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
