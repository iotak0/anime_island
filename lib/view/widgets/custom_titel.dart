import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/theme.dart';

class CustomTitle extends StatelessWidget {
  final String tital;
  const CustomTitle({
    super.key,
    required this.tital,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(tital,
              style: CustomTheme.darkTextTheme.displaySmall!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
