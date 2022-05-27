// importing required libraries
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// defining custom Button
class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.icon,
      this.bgColor = const Color(0xff209fa8),
      this.isLoading = false})
      : super(key: key);

  final String title;
  final Function onPressed;
  final IconData? icon;
  final Color bgColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isLoading) {
          onPressed();
        }
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          color: bgColor,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FaIcon(
                              icon,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                          ],
                        )
                      : Container(),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
      ),
    );
  }
}
