
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleAndText extends StatelessWidget {
  final String title;
  final String text;

  const TitleAndText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7760C0),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
