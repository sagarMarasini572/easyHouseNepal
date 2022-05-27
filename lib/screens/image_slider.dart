// ignore_for_file: unnecessary_this, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcard/tcard.dart';

class TCardPage extends StatefulWidget {
  final List images;
  final int index;

  const TCardPage({Key? key, required this.images, required this.index})
      : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _TCardPageState createState() => _TCardPageState(this.images, this.index);
}

class _TCardPageState extends State<TCardPage> {
  final TCardController _controller = TCardController();
  List images;
  int index;
  _TCardPageState(this.images, this.index);

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = List.generate(
      images.length,
      (int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23.0,
                spreadRadius: -13.0,
                color: Colors.black54,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: <Widget>[
              TCard(
                size: Size(Get.width, Get.height * 0.97), // Size of the card
                cards: cards,
                controller: _controller,
                onForward: (index, info) {
                  if (index == images.length) {
                    // index = 0;
                    _controller.reset();
                  } else {
                    index = index;
                  }
                  setState(() {});
                },
                onBack: (index, info) {
                  index = index;
                  setState(() {});
                },
                // onEnd: () {
                //   print('End');
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
