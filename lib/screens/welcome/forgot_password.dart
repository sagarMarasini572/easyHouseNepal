import 'package:easy_house_nepal/controllers/verify_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:easy_house_nepal/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

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
              child: GetBuilder<VerifyController>(builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hint: 'Enter your email address',
                      label: 'Email Address',
                      icon: FontAwesomeIcons.mailBulk,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 20),
                    controller.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: 'Send OTP',
                            isLoading: controller.isResendLoading,
                            onPressed: () {
                              controller.resendForgetPassword();
                            }),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () {
                        Get.toNamed(GetRoutes.login);
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Return To Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xfa209fa8),
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
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
