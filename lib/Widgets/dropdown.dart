import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_phone/Widgets/text.dart';
import '../colors.dart';

class MyDropdown extends StatelessWidget {
  final double width;
  final String hintText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final Widget icon;
  final Function(String? value) changeValue;
  final String? Function(String?)? validatorFunction;
  final bool enabled;

  const MyDropdown({
    super.key,
    required this.width,
    required this.hintText,
    required this.value,
    required this.items,
    required this.changeValue,
    required this.icon,
    this.validatorFunction,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          enabled: enabled,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: MyColors().myBlue,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: MyColors().myRed,
              width: 1,
            ),
          ),
          errorStyle: GoogleFonts.rubik(
            fontSize: 14,
            color: MyColors().myRed,
            fontWeight: FontWeight.normal,
          ),
          errorMaxLines: 10,
        ),
        hint: MyText(
          text: hintText,
          size: 16,
          weight: FontWeight.normal,
          color: Colors.grey,
        ),
        value: value,
        items: items,
        onChanged: enabled ? changeValue : null,
        validator: validatorFunction,
      ),
    );
  }
}
