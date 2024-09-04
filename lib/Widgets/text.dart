import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign? align;
  final TextOverflow overflow;
  final TextDecoration? decoration;

  const MyText({
    super.key,
    required this.text,
    required this.size,
    required this.weight,
    required this.color,
    this.align,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.rubik(
        fontSize: size,
        fontWeight: weight,
        color: color,
        decoration: decoration,
      ),
      textAlign: align ??
          (Get.locale?.languageCode == 'en' ? TextAlign.left : TextAlign.right),
      overflow: overflow,
    );
  }
}
