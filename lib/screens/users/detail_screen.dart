import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/controllers/property_controller.dart';
import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/screens/image_slider.dart';
import 'package:easy_house_nepal/screens/users/payment/payment_selector_screen.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  final Property property = Get.arguments;
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(baseUrl + property.images![0].imgPath!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.colorBurn,
                  ),
                )),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 10,
                    ),
                  ),
                ),
              ),
              if (homeController.user.role == 'user')
                Positioned(
                  top: 40,
                  right: 20,
                  child: GetBuilder<HomeController>(builder: (controller) {
                    return InkWell(
                      onTap: () {
                        controller.addToWishList(property.propertyId);
                      },
                      child: FaIcon(
                        homeController.properties
                                .where((element) => element.isWished == true)
                                .toList()
                                .where(
                                    (e) => e.propertyId == property.propertyId)
                                .isNotEmpty
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                    );
                  }),
                ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: property.isBooked! == true
                              ? Colors.redAccent
                              : Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          property.isBooked! == true ? 'Booked' : 'Available',
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      property.propertyTitle!,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Rs.${property.propertyPrice}/months',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Color(0xb2000000),
                          height: 1.25,
                        ),
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                Icons.location_on_sharp,
                                size: 25,
                                color: Color(0xff209fa8),
                              ),
                            ),
                          ),
                          TextSpan(
                              text:
                                  '${property.province} , ${property.district} , ${property.city} , ${property.tole}'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
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
                    Wrap(
                      children: [
                        ['${property.noOfBedrooms} beds', 0],
                        ['${property.noOfBathrooms} baths', 1],
                        ['${property.noOfKitchens} kitchens', 2],
                      ]
                          .map(
                            (e) => Container(
                              margin:
                                  const EdgeInsets.only(right: 5, bottom: 5),
                              width: MediaQuery.of(context).size.width / 3.49,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
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
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    e[0].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w500,
                                      height: 1.75,
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
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
                    Text(
                      '${property.propertyDescription}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 20,
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: property.images!
                            .map(
                              (image) => InkWell(
                                onTap: () => Get.to(
                                  () => (TCardPage(
                                      images: property.images!
                                          .map((e) => baseUrl + e.imgPath!)
                                          .toList(),
                                      index: 0)),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            baseUrl + image.imgPath!),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.3),
                                          BlendMode.colorBurn,
                                        ),
                                      )),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Area & Floors Details',
                      style: TextStyle(
                        fontSize: 20,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(columns: const [
                        DataColumn(
                          label: Text(
                            'Area',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Age',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Floors',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Rooms',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ], rows: [
                        DataRow(cells: [
                          DataCell(Text('${property.propertyArea}')),
                          DataCell(Text('${property.propertyAge}')),
                          DataCell(Text('${property.noOfFloors}')),
                          DataCell(Text('${property.noOfRooms}')),
                        ])
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Other Details',
                      style: TextStyle(
                        fontSize: 20,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Contract ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'House No.',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Facing',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('${property.contractDuration}')),
                            DataCell(Text('${property.propertyHouseNo}')),
                            DataCell(Text('${property.facingDirection}')),
                          ])
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Contact Details',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name: ' + property.ownerName!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Email: ' + property.ownerEmail!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Phone: ' + property.ownerContact!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    homeController.user.role == 'user'
                        ? Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  title: 'Call',
                                  onPressed: () async {
                                    if (!await launch(
                                        'tel:${property.ownerContact}')) {
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Could not make a call!'),
                                            );
                                          });
                                    }
                                  },
                                  icon: FontAwesomeIcons.phoneAlt,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomButton(
                                  title: 'Rent',
                                  onPressed: () {
                                    if (property.isBooked!) {
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return const AlertDialog(
                                              title: Text('Information'),
                                              content: Text(
                                                  'This property is already booked!'),
                                            );
                                          });
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentSelector(
                                              propertyDetail: property),
                                        ),
                                      );
                                    }
                                  },
                                  icon: FontAwesomeIcons.key,
                                ),
                              ),
                            ],
                          )
                        : CustomButton(
                            title: 'Edit',
                            onPressed: () {
                              PropertyController propertyController =
                                  Get.find();
                              propertyController.editProperty(property);
                              Get.toNamed(GetRoutes.addHouse, arguments: true);
                            },
                            icon: FontAwesomeIcons.pencilAlt,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
