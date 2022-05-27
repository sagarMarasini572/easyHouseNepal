import 'package:easy_house_nepal/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      drawer: const CustomDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: const [
                  SizedBox(
                    height: 40,
                  ),
                  Image(
                    image: AssetImage('assets/images/easyhouse.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'EasyHouse Nepal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003399),
                    ),
                  ),
                  Text(
                    'Est. 2021',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003399),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'easyHouseNepal is a real estate marketplace that allows easy search, and renting properties (apartments/houses) to potential customers throughout Nepal.',
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 18,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'easyHouseNepal is established with the foundation of trust achieved through comuncation and support. We will provide you with more information, answer any questions you may have and present before you a cost destination. So give us a shout!',
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 18,
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
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
