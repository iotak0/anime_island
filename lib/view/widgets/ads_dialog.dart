import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AdsDialog extends StatelessWidget {
  const AdsDialog({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      backgroundColor: tkDarkerBlue,
      contentPadding: EdgeInsets.only(top: 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: tkDarkerBlue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Text(
                'شاهد اعلان',
                style: CustomTheme.darkTextTheme.displaySmall!
                    .copyWith(color: tkDarkBlue),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'الرجاء مشاهدة الاعلان للمتابة للصفحة التالية',
                style: CustomTheme.darkTextTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Colors.grey,
              height: 4.0,
            ),
            Row(children: <Widget>[
              Expanded(
                  child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20))),
                height: 50,
                minWidth: double.infinity,
                onPressed: onPressed,
                child: Text(
                  'موافق',
                  style: CustomTheme.darkTextTheme.titleMedium,
                ),
              )),
               Container(
                height: 50,
                color: Colors.white,
                width: 0.4,
              ),
              Expanded(
                  child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(20))),
                height: 50,
                minWidth: double.infinity,
                onPressed: () {
                  SmartDialog.dismiss();
                },
                child: Text(
                  'رجوع',
                  style: CustomTheme.darkTextTheme.titleMedium!
                      .copyWith(color: Colors.grey),
                ),
              )),
             
            ])
          ],
        ),
      ),
    );
  }
}
