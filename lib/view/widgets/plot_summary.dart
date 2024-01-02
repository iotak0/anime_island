import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/theme.dart';

class PlotSummary extends StatelessWidget {
  const PlotSummary({
    Key? key,
    required this.summary,
  }) : super(key: key);
  final String summary;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Color.fromARGB(255, 104, 208, 240),
      iconColor: Color.fromARGB(255, 104, 208, 240),
      title: Text(
        'القصة',
        style: CustomTheme.darkTextTheme.displaySmall!,
      ),
      childrenPadding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            summary,
            style: CustomTheme.darkTextTheme.bodySmall!,
          ),
        ),
      ],
    );
  }
}
