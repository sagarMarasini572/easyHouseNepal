import 'package:easy_house_nepal/controllers/payment_controller.dart';
import 'package:easy_house_nepal/model/property.dart';
import 'package:easy_house_nepal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:khalti/khalti.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class WalletPayment extends StatefulWidget {
  const WalletPayment({Key? key, required this.propertyDetail})
      : super(key: key);

  final Property propertyDetail;

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {
  late final TextEditingController _mobileController, _pinController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final paymentController = Get.find<PaymentController>();
  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      return Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (v) => (v?.isEmpty ?? true) ? 'Required ' : null,
              decoration: const InputDecoration(
                label: Text('Khalti Mobile Number'),
                icon: FaIcon(FontAwesomeIcons.addressBook),
              ),
              controller: _mobileController,
            ),
            TextFormField(
              obscureText: true,
              validator: (v) => (v?.isEmpty ?? true) ? 'Required ' : null,
              decoration: const InputDecoration(
                label: Text(
                  'Khalti MPIN',
                ),
                icon: FaIcon(FontAwesomeIcons.lock),
              ),
              controller: _pinController,
            ),
            const SizedBox(height: 24),
            CustomButton(
                title: 'Make Payment',
                onPressed: () async {
                  if (!(_formKey.currentState?.validate() ?? false)) return;

                  final initiationModel = await Khalti.service.initiatePayment(
                    request: PaymentInitiationRequestModel(
                      amount: 1000, // Amount should be in paisa
                      mobile: _mobileController.text,
                      productIdentity: widget.propertyDetail.propertyId!,
                      productName: widget.propertyDetail.propertyTitle!,
                      transactionPin: _pinController.text,
                      productUrl: '',
                      additionalData: {},
                    ),
                  );

                  final otpCode = await showDialog<String>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      String? _otp;
                      return AlertDialog(
                        title: const Text('OTP Sent!'),
                        content: TextField(
                          decoration: const InputDecoration(
                            label: Text('OTP Code'),
                          ),
                          onChanged: (v) => _otp = v,
                        ),
                        actions: [
                          SimpleDialogOption(
                            child: const Text('Submit'),
                            onPressed: () => Navigator.pop(context, _otp),
                          )
                        ],
                      );
                    },
                  );

                  if (otpCode != null) {
                    try {
                      final model = await Khalti.service.confirmPayment(
                        request: PaymentConfirmationRequestModel(
                          confirmationCode: otpCode,
                          token: initiationModel.token,
                          transactionPin: _pinController.text,
                        ),
                      );

                      controller.makeBookings(
                          widget.propertyDetail, model.token);
                    } catch (e) {
                      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                }),
          ],
        ),
      );
    });
  }
}

class Banking extends StatefulWidget {
  const Banking({Key? key, required this.paymentType}) : super(key: key);

  final PaymentType paymentType;

  @override
  State<Banking> createState() => _BankingState();
}

class _BankingState extends State<Banking> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<BankListModel>(
      future: Khalti.service.getBanks(paymentType: widget.paymentType),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final banks = snapshot.data!.banks;
          return ListView.builder(
            itemCount: banks.length,
            itemBuilder: (context, index) {
              final bank = banks[index];

              return ListTile(
                leading: SizedBox.square(
                  dimension: 40,
                  child: Image.network(bank.logo),
                ),
                title: Text(bank.name),
                subtitle: Text(bank.shortName),
                onTap: () async {
                  final mobile = await showDialog<String>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      String? _mobile;
                      return AlertDialog(
                        title: const Text('Enter Mobile Number'),
                        content: TextField(
                          decoration: const InputDecoration(
                            label: Text('Mobile Number'),
                          ),
                          onChanged: (v) => _mobile = v,
                        ),
                        actions: [
                          SimpleDialogOption(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context, _mobile),
                          )
                        ],
                      );
                    },
                  );

                  if (mobile != null) {
                    final url = Khalti.service.buildBankUrl(
                      bankId: bank.idx,
                      amount: 1000,
                      mobile: mobile,
                      productIdentity: '',
                      productName: '',
                      paymentType: widget.paymentType,
                      returnUrl: '',
                    );

                    url_launcher.launch(url);
                  }
                },
              );
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
