import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class MixifyWidget extends StatelessWidget {
  final double textHeight;
  final Color ixifyColor;
  const MixifyWidget({super.key, required this.textHeight, required this.ixifyColor});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "M",
          style: GoogleFonts.oswald(
              color: kPrimaryColor,
              fontSize: textHeight,
              fontWeight: FontWeight.bold)),
      TextSpan(
          text: "IXIFY",
          style: GoogleFonts.oswald(
              color: ixifyColor,
              fontSize: textHeight,
              fontWeight: FontWeight.bold))
    ]));
  }
}
