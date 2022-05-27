import 'package:easy_house_nepal/controllers/default_controller.dart';
import 'package:easy_house_nepal/controllers/verify_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  Welcome({Key? key}) : super(key: key);

  final defaultController = Get.find<DefaultController>();
  final verifyController = Get.find<VerifyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  const Image(
                    image: AssetImage('assets/images/easyhouse.png'),
                  ),
                  const Text(
                    'EasyHouse Nepal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003399),
                    ),
                  ),
                  const Text(
                    'Est. 2021',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003399),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Let’s get started by logging into your account',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xb2000000),
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    title: 'CREATE FREE ACCOUNT',
                    onPressed: () {
                      Get.toNamed(GetRoutes.signup);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: 'SIGN IN',
                    onPressed: () {
                      Get.toNamed(GetRoutes.login);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
