import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading(
      {super.key,
      required this.radius,
      required this.width,
      required this.height});
  final double radius, width, height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: PColors.darkColor,
        highlightColor: PColors.darkColor.withOpacity(.1),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: PColors.darkColor,
              borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
