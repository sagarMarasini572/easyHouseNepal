// importing required libaries
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// defining custom DropDown
class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {Key? key,
      required this.dropdownItems,
      required this.selected,
      required this.onChanged,
      required this.title})
      : super(key: key);

  final List dropdownItems;
  final String selected;
  final Function onChanged;
  final String title;

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
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0x60000000)))),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selected,
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: 15,
                  ),
                  elevation: 16,
                  style: const TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 131, 131, 131)),
                  underline: Container(),
                  onChanged: (String? newValue) {
                    onChanged(newValue);
                  },
                  items: dropdownItems.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
