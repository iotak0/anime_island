import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/helper.dart';
import 'package:flutter_application_1/utils/color.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {super.key,
      required this.radius,
      required this.width,
      required this.height,
      required this.imageUrl});
  final double radius, width, height;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        color: Colors.black.withOpacity(.5),
        colorBlendMode: BlendMode.difference,
        cacheManager: Helper.cacheManager,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: PColors.darkColor,
              borderRadius: BorderRadius.circular(radius)),
        ),
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: PColors.darkColor,
              borderRadius: BorderRadius.circular(radius)),
        ),
      ),
    );
  }
}
