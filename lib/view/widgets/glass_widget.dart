import 'dart:ui';

import 'package:flutter/material.dart';

class GlassWidget extends StatelessWidget {
  final Widget child;

  GlassWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(16),
            color: Colors.white.withOpacity(0.2),
            child: child,
          ),
        ),
      ),
    );
  }
}