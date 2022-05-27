import 'package:easy_house_nepal/controllers/signup_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:easy_house_nepal/widgets/custom_textform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final singupController = Get.find<SignupController>();

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
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: GetBuilder<SignupController>(builder: (controller) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 36,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hint: 'Enter you full name',
                        label: 'Full Name',
                        icon: FontAwesomeIcons.solidUserCircle,
                        controller: controller.fullNameController,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hint: 'Enter you contact number',
                        label: 'Contact Number',
                        icon: FontAwesomeIcons.phoneAlt,
                        controller: controller.contactController,
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
                        obscureText: controller.isPasswordObscure,
                        isPassword: true,
                        controller: controller.passwordController,
                        onPasswordToggle: () {
                          controller.isPasswordObscure =
                              !controller.isPasswordObscure;
                          controller.update();
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hint: 'Confirm your password',
                        label: 'Re-enter password',
                        icon: FontAwesomeIcons.userLock,
                        obscureText: controller.isConfirmPasswordObscure,
                        isPassword: true,
                        controller: controller.confirmPasswordController,
                        onPasswordToggle: () {
                          controller.isConfirmPasswordObscure =
                              !controller.isConfirmPasswordObscure;
                          controller.update();
                        },
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                          title: 'Register',
                          isLoading: controller.isLoading,
                          onPressed: () {
                            controller.checkSignup();
                          }),
                      const SizedBox(height: 20),
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
                                text: 'Joined Us Before?',
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
                                    Get.toNamed(GetRoutes.login);
                                  },
                                text: 'Login',
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
          )
        ],
      ),
    );
  }
}
