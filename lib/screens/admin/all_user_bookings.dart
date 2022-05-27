import 'package:easy_house_nepal/controllers/all_user_boookings_controller.dart';
import 'package:easy_house_nepal/model/all_user_booking.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AllUserBookings extends StatelessWidget {
  const AllUserBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text('Users Bookings'),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: GetBuilder<AllUserBookingController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: controller.allUserBooking
                        .map(
                          (AllUserBooking al) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Booked on: ' + al.bookDate!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AllUserBookingTile(
                                allUserBooking: al,
                              ),
                            ],
                          ),
                        )
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

class AllUserBookingTile extends StatelessWidget {
  AllUserBookingTile({
    Key? key,
    this.allUserBooking,
  }) : super(key: key);

  final AllUserBooking? allUserBooking;
  final AllUserBookingController allUserBookingController = Get.find();

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
                  image: NetworkImage(
                      baseUrl + allUserBooking!.images![0].imgPath!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.redAccent),
                      child: Text(
                        allUserBooking!.isbooked! == true
                            ? 'Booked'
                            : 'Available',
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
                allUserBooking!.propertyTitle!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Rs.${allUserBooking!.propertyPrice}/months',
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
                allUserBooking!.propertyDescription!,
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
                  ['${allUserBooking!.noOfBedrooms} beds', 0],
                  ['${allUserBooking!.noOfBathrooms} baths', 1],
                  ['${allUserBooking!.noOfKitchens} kitchens', 2],
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
