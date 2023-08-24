import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? textSize;
  final Color? color;
  final bool? isOverFlood;
  const CustomText(
      {super.key,
      required this.text,
      this.fontWeight,
      this.textAlign,
      this.textSize,
      this.isOverFlood,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow:isOverFlood == null || isOverFlood == false? null: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: GoogleFonts.oswald(
          fontSize: textSize ?? 15, fontWeight: fontWeight, color: color),
    );
  }
}
