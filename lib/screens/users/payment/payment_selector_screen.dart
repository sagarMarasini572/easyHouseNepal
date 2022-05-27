import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/screens/users/payment/wallet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khalti/khalti.dart';

class PaymentSelector extends StatelessWidget {
  const PaymentSelector({Key? key, required this.propertyDetail})
      : super(key: key);

  final Property propertyDetail;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Payment Method'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'KHALTI',
                icon: FaIcon(FontAwesomeIcons.wallet),
              ),
              Tab(
                text: 'E-BANKING',
                icon: FaIcon(FontAwesomeIcons.building),
              ),
              Tab(
                text: 'MOBILE BANKING',
                icon: FaIcon(FontAwesomeIcons.laptopHouse),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const Image(
              image: AssetImage(
                'assets/images/khaltiPayment.png',
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  WalletPayment(propertyDetail: propertyDetail),
                  const Banking(paymentType: PaymentType.eBanking),
                  const Banking(paymentType: PaymentType.mobileCheckout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
