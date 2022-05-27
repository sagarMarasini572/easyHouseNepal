// importing required libaries
import 'package:flutter/material.dart';

// defining custom Full TextFormField
class CustomTextFormFieldFull extends StatelessWidget {
  const CustomTextFormFieldFull({
    Key? key,
    required this.title,
    required this.hint,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  }) : super(key: key);

  final String title;
  final String hint;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
            height: 1.25,
          ),
          textAlign: TextAlign.left,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(hintText: hint),
        )
      ],
    );
  }
}
