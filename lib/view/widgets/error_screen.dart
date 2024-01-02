
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.ontTap,
  });
  final GestureTapCallback ontTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height - 100,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'حدث خطأ ما الرجاء اعادة المحاولة',
            style: CustomTheme.darkTextTheme.bodySmall!,
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: PColors.premiumColor),
              onPressed: ontTap,
              child: Text(
                'اعادة المحاولة',
                style: CustomTheme.darkTextTheme.bodySmall!,
              ))
        ],
      ),
    );
  }
}
