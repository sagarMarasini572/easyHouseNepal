// importing required libaries
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// defining custom TextFormField
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.hint = "",
      required this.icon,
      this.label = "",
      this.keyboardType = TextInputType.text,
      this.controller,
      this.obscureText = false,
      this.isPassword = false,
      this.onPasswordToggle})
      : super(key: key);

  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Function? onPasswordToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              size: 25,
              color: const Color(0xff209fab),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.black, width: 1)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      obscureText: obscureText,
                      keyboardType: keyboardType,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: label,
                        labelStyle: TextStyle(
                            color: const Color(0xff000000).withOpacity(0.5)),
                        hintText: hint,
                        hintStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xb2000000),
                          height: 1.25,
                        ),
                      ),
                    ),
                  ),
                  isPassword
                      ? InkWell(
                          onTap: () {
                            onPasswordToggle!();
                          },
                          child: obscureText
                              ? const FaIcon(
                                  FontAwesomeIcons.solidEyeSlash,
                                  size: 20,
                                )
                              : const FaIcon(
                                  FontAwesomeIcons.solidEye,
                                  size: 20,
                                ),
                        )
                      : Container(),
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }
}
