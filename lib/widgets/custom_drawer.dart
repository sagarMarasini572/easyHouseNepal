// importing required libaries
import 'package:easy_house_nepal/controllers/home_controller.dart';
import 'package:easy_house_nepal/controllers/profile_controller.dart';
import 'package:easy_house_nepal/routes.dart';
import 'package:easy_house_nepal/utils/baseurl.dart';
import 'package:easy_house_nepal/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// defining custom drawer
class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child:
                  GetBuilder<ProfileController>(builder: (profileController) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    // child: const Icon(Icons.person, size: 100));
                    child: Image(
                      fit: BoxFit.cover,
                      image: profileController.user.profileImage == ''
                          ? NetworkImage(
                              'https://ui-avatars.com/api/?background=random' +
                                  profileController.user.fullName!,
                            )
                          : NetworkImage(
                              baseUrl + profileController.user.profileImage!,
                            ),
                    ));
                // child: profileController.user.profileImage == ''
                //     ? const Icon(Icons.person, size: 100)
                //     : Image(
                //         fit: BoxFit.cover,
                //         image: NetworkImage(
                //           baseUrl + profileController.user.profileImage!,
                //         ),
                //       ));
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              controller.user.fullName!,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30,
                color: Color(0xfa209fa8),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  drawerComponent('Home', FontAwesomeIcons.home, () {
                    Get.toNamed(GetRoutes.home);
                  }),
                  controller.user.role == 'admin'
                      ? adminDrawerItem()
                      : customerDrawerItem(),
                ],
              ),
            ),
            drawerComponent('Sign Out', FontAwesomeIcons.signOutAlt, () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Sign Out?'),
                        content:
                            const Text('Are you sure you want to sign out?'),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red[700]),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                await SharedPrefs().removeUser();
                                Get.toNamed(GetRoutes.welcome);
                              },
                              child: const Text('Confirm'))
                        ],
                      ));
            })
          ],
        );
      }),
    );
  }

  // defining customer Drawer Item
  Column customerDrawerItem() {
    return Column(
      children: [
        drawerComponent('Profile', FontAwesomeIcons.userAlt, () {
          Get.toNamed(GetRoutes.profile);
        }),
        drawerComponent('My Bookings', FontAwesomeIcons.bookOpen, () {
          Get.toNamed(GetRoutes.bookings);
        }),
        drawerComponent('WishList', FontAwesomeIcons.solidHeart, () {
          Get.toNamed(GetRoutes.wishlist);
        }),
        drawerComponent('Change Password', FontAwesomeIcons.userAlt, () {
          Get.toNamed(GetRoutes.changePassword);
        }),
        drawerComponent('Contact Us', FontAwesomeIcons.phoneAlt, () {
          Get.toNamed(GetRoutes.contactUs);
        }),
        drawerComponent('About Us', FontAwesomeIcons.info, () {
          Get.toNamed(GetRoutes.aboutUs);
        }),
        drawerComponent('Our Mission', FontAwesomeIcons.bullseye, () {
          Get.toNamed(GetRoutes.ourMission);
        }),
      ],
    );
  }

  // defining admin Drawer Item
  Column adminDrawerItem() {
    return Column(children: [
      
      drawerComponent('Add House', FontAwesomeIcons.houseUser, () {
        Get.toNamed(GetRoutes.addHouse);
      }),
      drawerComponent('Users Booking', FontAwesomeIcons.bookOpen, () {
        Get.toNamed(GetRoutes.allUserBookings);
      }),
      drawerComponent('Registered User', FontAwesomeIcons.userAlt, () {
        Get.toNamed(GetRoutes.userList);
      }),
    ]);
  }

  // defining drawer Component
  ListTile drawerComponent(title, icon, onTap) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      leading: FaIcon(
        icon,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xff000000),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
