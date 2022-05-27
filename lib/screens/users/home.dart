import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/controllers/profile_controller.dart';
import 'package:easy_house_nepal/controllers/property_controller.dart';
import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final homeController = Get.find<HomeController>();
  final propertyController = Get.find<PropertyController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (homeController.user.role == 'user')
            IconButton(
                icon: GetBuilder<ProfileController>(builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: controller.user.profileImage == ''
                        ? NetworkImage(
                            'https://ui-avatars.com/api/?background=random&name=${controller.user.fullName}',
                          )
                        : NetworkImage(
                            baseUrl + controller.user.profileImage!,
                          ),
                  ),
                ),
              );
            }), onPressed: () {
              Get.toNamed(GetRoutes.profile);
            }),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: GetBuilder<HomeController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.user.role == 'admin'
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${controller.user.fullName}!',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0x80545454),
                            height: 1.3,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Text(
                          'Find your sweet Home',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                    width: MediaQuery.of(context).size.width / 1.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xffffffff),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.search,
                          size: 20,
                          color: Color(0xffB5B5B5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (val) {
                              controller.search(val);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for home . . . ',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (int.parse(
                              controller.filteredProperties[0].propertyPrice!) >
                          int.parse(controller
                              .filteredProperties[
                                  controller.filteredProperties.length - 1]
                              .propertyPrice!)) {
                        controller.filteredProperties.sort((a, b) {
                          return a.propertyPrice!.compareTo(b.propertyPrice!);
                        });
                      } else {
                        controller.filteredProperties.sort((a, b) {
                          return b.propertyPrice!.compareTo(a.propertyPrice!);
                        });
                      }
                      controller.update();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      width: MediaQuery.of(context).size.width / 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xffffffff),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.sortAlphaDownAlt,
                            size: 20,
                            color: Color(0xffB5B5B5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Properties',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.filteredProperties
                        .map((Property p) => InkWell(
                            onTap: () {
                              Get.toNamed(GetRoutes.detailScreen,
                                  arguments: p);
                            },
                            child: PropertyListTile(
                              property: p,
                            )))
                        .toList(),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class PropertyListTile extends StatelessWidget {
  PropertyListTile({
    Key? key,
    this.property,
  }) : super(key: key);

  final Property? property;
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withOpacity(0.6),
            offset: const Offset(0, 0.75),
            blurRadius: 4.4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 8.0, right: 8.0),
            child: Container(
              height: 210,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage(baseUrl + property!.images![0].imgPath!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  if (homeController.user.role == 'user')
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FaIcon(
                        property!.isWished! == true
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Colors.redAccent,
                      ),
                    ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 5),
                      decoration: BoxDecoration(
                        color: property!.isBooked! == true
                            ? Colors.redAccent
                            : Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        property!.isBooked! == true ? 'Booked' : 'Available',
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                property!.propertyTitle!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Rs.${property!.propertyPrice}/months',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                property!.propertyDescription!,
                maxLines: 5,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Color(0xb2000000),
                  height: 1.23,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                children: [
                  ['${property!.noOfBedrooms} beds', 0],
                  ['${property!.noOfBathrooms} baths', 1],
                  ['${property!.noOfKitchens} kitchens', 2],
                ]
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.only(right: 2, bottom: 5),
                        width: MediaQuery.of(context).size.width / 4.7,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: const Color(0xff209fa8),
                        ),
                        child: Row(
                          children: [
                            FaIcon(
                              e[1] == 0
                                  ? FontAwesomeIcons.bed
                                  : e[1] == 1
                                      ? FontAwesomeIcons.bath
                                      : FontAwesomeIcons.utensils,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              e[0].toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                                height: 1.23,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          )),
        ],
      ),
    );
  }
}
