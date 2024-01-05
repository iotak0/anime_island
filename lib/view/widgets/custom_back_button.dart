import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => Get.back(),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: PColors.darkBackground.withOpacity(.5)),
            child: const Icon(Icons.arrow_back_ios_new_rounded)));
  }
}
