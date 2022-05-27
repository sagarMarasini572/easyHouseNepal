// importing required libaries
import 'package:easy_house_nepal/binding/all_user_booking_binding.dart';
import 'package:easy_house_nepal/binding/changepassword_binding.dart';
import 'package:easy_house_nepal/binding/login_binding.dart';
import 'package:easy_house_nepal/binding/sign_up_binding.dart';
import 'package:easy_house_nepal/binding/user_binding.dart';
import 'package:easy_house_nepal/binding/welcome_binding.dart';
import 'package:easy_house_nepal/binding/home_binding.dart';
import 'package:easy_house_nepal/screens/admin/add_house.dart';
import 'package:easy_house_nepal/screens/admin/all_user_bookings.dart';
import 'package:easy_house_nepal/screens/admin/user_list.dart';
import 'package:easy_house_nepal/screens/users/bookings.dart';
import 'package:easy_house_nepal/screens/users/detail_screen.dart';
import 'package:easy_house_nepal/screens/users/home.dart';
import 'package:easy_house_nepal/screens/users/wishlist.dart';
import 'package:easy_house_nepal/screens/welcome/aboutus.dart';
import 'package:easy_house_nepal/screens/welcome/change_password.dart';
import 'package:easy_house_nepal/screens/welcome/contactus.dart';
import 'package:easy_house_nepal/screens/welcome/forgot_password.dart';
import 'package:easy_house_nepal/screens/welcome/login.dart';
import 'package:easy_house_nepal/screens/welcome/mission.dart';
import 'package:easy_house_nepal/screens/welcome/profile.dart';
import 'package:easy_house_nepal/screens/welcome/register.dart';
import 'package:easy_house_nepal/screens/welcome/reset_password.dart';
import 'package:easy_house_nepal/screens/welcome/verify_screen.dart';
import 'package:easy_house_nepal/screens/welcome/welcome.dart';
import 'package:get/get.dart';

class GetRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String detailScreen = '/detail-screen';
  static const String changePassword = '/change-password';
  static const String profile = '/profile';
  static const String wishlist = '/wishlist';
  static const String addHouse = '/add-house';
  static const String verify = '/verify';
  static const String bookings = '/bookings';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String contactUs = '/contact';
  static const String aboutUs = '/about';
  static const String ourMission = '/mission';
  static const String userList = '/user-list';
  static const String allUserBookings = '/all-user-bookings';

  static List<GetPage> routes = [
    GetPage(
      name: GetRoutes.welcome,
      page: () => Welcome(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: GetRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: GetRoutes.signup,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: GetRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: GetRoutes.changePassword,
        page: () => ChangePassword(),
        binding: ChangePasswordBinding()),
    GetPage(
      name: GetRoutes.profile,
      page: () => const Profile(),
    ),
    GetPage(
      name: GetRoutes.detailScreen,
      page: () => DetailScreen(),
    ),
    GetPage(
      name: GetRoutes.wishlist,
      page: () => const Wishlist(),
    ),
    GetPage(
      name: GetRoutes.bookings,
      page: () => const Bookings(),
    ),
    GetPage(
      name: GetRoutes.addHouse,
      page: () => AddHouse(),
    ),
    GetPage(
      name: GetRoutes.verify,
      page: () => const VerifyScreen(),
    ),
    GetPage(
      name: GetRoutes.forgotPassword,
      page: () => const ForgotPassword(),
    ),
    GetPage(
      name: GetRoutes.resetPassword,
      page: () => const ResetPassword(),
    ),
    GetPage(
      name: GetRoutes.contactUs,
      page: () => const ContactUs(),
    ),
    GetPage(
      name: GetRoutes.aboutUs,
      page: () => const AboutUs(),
    ),
    GetPage(
      name: GetRoutes.ourMission,
      page: () => const OurMission(),
    ),
    GetPage(
      name: GetRoutes.userList,
      page: () => UserList(),
      binding: UserBinding(),
    ),
    GetPage(
      name: GetRoutes.allUserBookings,
      page: () => const AllUserBookings(),
      binding: AllUserBookingBinding(),
    ),
  ];
}
