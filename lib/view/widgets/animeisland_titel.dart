

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeIslandTtle extends StatelessWidget {
  const AnimeIslandTtle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.cairo().copyWith(
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          RotateAnimatedText(
            'انمي ايلاند',
            duration: Duration(seconds: 3),
          ),
          RotateAnimatedText(
            'AnimeIsland',
            duration: Duration(seconds: 3),
            textStyle: GoogleFonts.rubikBubbles().copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          RotateAnimatedText(
            'جزيرة الانمي',
            duration: Duration(seconds: 3),
          ),
        ],
        repeatForever: true,
        isRepeatingAnimation: true,
      ),
    );
  }
}
