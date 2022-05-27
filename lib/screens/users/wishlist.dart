import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/screens/users/home.dart';
import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      drawer: const CustomDrawer(),
      body: GetBuilder<HomeController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: controller.properties
                .where((element) => element.isWished == true)
                .map(
                  (p) => InkWell(
                    onTap: () {
                      Get.toNamed(GetRoutes.detailScreen, arguments: p);
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              controller.addToWishList(p.propertyId);
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 80,
                                alignment: Alignment.center,
                                color: Colors.red,
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  'Remove from WishList',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )),
                          );
                        },
                      );
                    },
                    child: PropertyListTile(
                      property: p,
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
