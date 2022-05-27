// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:easy_house_nepal/controllers/login_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:easy_house_nepal/widgets/custom_textform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final loginController = Get.find<LoginController>();

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
              child: SingleChildScrollView(
                child: GetBuilder<LoginController>(builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hint: 'Enter you email',
                        label: 'Email',
                        icon: FontAwesomeIcons.mailBulk,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hint: 'Enter you password',
                        label: 'Password',
                        icon: FontAwesomeIcons.userLock,
                        obscureText: controller.isPasswordObscureText,
                        isPassword: true,
                        controller: controller.passwordController,
                        onPasswordToggle: () {
                          controller.isPasswordObscureText =
                              !controller.isPasswordObscureText;
                          controller.update();
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.toNamed(GetRoutes.forgotPassword);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'Forgot Password?',
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
                      const SizedBox(height: 30),
                      CustomButton(
                          title: 'Log In',
                          isLoading: controller.isLoading,
                          onPressed: () {
                            controller.checkLogin();
                          }),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xb2969696),
                              height: 1.25,
                            ),
                            children: [
                              const TextSpan(
                                text: 'New to Logistics?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(GetRoutes.signup);
                                  },
                                text: 'Register',
                                style: const TextStyle(
                                  color: Color(0xfa209fa8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
