// ignore_for_file: unnecessary_const

import 'package:easy_house_nepal/controllers/verify_controller.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({Key? key}) : super(key: key);

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
          GetBuilder<VerifyController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 36,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'An 6 digit code has been sent to your register email Address',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Color(0xb2969696),
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: PinCodeTextField(
                        controller: controller.verifyController,
                        appContext: context,
                        length: 6,
                        onChanged: (val) {},
                        animationType: AnimationType.fade,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        textStyle: const TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0XFF2A3147),
                            fontSize: 25),
                        cursorColor: const Color(0XFF2A3147),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          inactiveColor: const Color(0XFFffffff),
                          selectedColor: const Color(0XFFffffff),
                          activeColor: const Color(0XFFffffff),
                          inactiveFillColor: const Color(0XFFE6E6E6),
                          activeFillColor: const Color(0XFFE6E6E6),
                          selectedFillColor: const Color(0XFFE6E6E6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    CustomButton(
                      title: 'Verify',
                      isLoading:
                          controller.isLoading || controller.isResendLoading,
                      onPressed: () async {
                        controller.verify();
                      },
                    ),
                    const SizedBox(height: 35),
                    controller.isResendLoading
                        ? const LinearProgressIndicator()
                        : InkWell(
                            onTap: () {
                              controller.resendCode();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Resend Code',
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
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
