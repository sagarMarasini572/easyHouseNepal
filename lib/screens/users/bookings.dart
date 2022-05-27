import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/screens/users/home.dart';
import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bookings extends StatelessWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      drawer: const CustomDrawer(),
      body: GetBuilder<HomeController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: controller.properties
                .where((element) =>
                    element.isBooked == true && element.bookedDate != null)
                .map(
                  (p) => InkWell(
                    onTap: () {
                      Get.toNamed(GetRoutes.detailScreen, arguments: p);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Booked on: ' + p.bookedDate!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        PropertyListTile(
                          property: p,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      }),
    );
  }
}
