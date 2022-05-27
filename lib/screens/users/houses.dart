import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/controllers/property_controller.dart';
import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HouseScreen extends StatelessWidget {
  HouseScreen({Key? key}) : super(key: key);

  final homeController = Get.find<HomeController>();
  final propertyController = Get.find<PropertyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 15,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Houses'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: GetBuilder<HomeController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.filteredProperties
                        .map((Property p) => InkWell(
                            onTap: () {
                              Get.toNamed(GetRoutes.detailScreen, arguments: p);
                            },
                            child: HousesListTile(
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

class HousesListTile extends StatelessWidget {
  HousesListTile({
    Key? key,
    this.property,
  }) : super(key: key);

  final Property? property;
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
            padding: const EdgeInsets.all(8.0),
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
                        width: 85,
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
