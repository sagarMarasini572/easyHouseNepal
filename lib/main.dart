import 'package:easy_house_nepal/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti/khalti.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
    publicKey: 'test_public_key_9eb6da1a064e4532abd510b048de81ff',
    enabledDebugging: false,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EasyHouse Nepal',
      debugShowCheckedModeBanner: false,
      // transition slow
      transitionDuration: const Duration(milliseconds: 1000),
      // default transition
      defaultTransition: Transition.fade,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff209FA8),
          ),
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          primaryColor: const Color(0xFF209FA8)),
      initialRoute: GetRoutes.welcome,
      getPages: GetRoutes.routes,
    );
  }
}
