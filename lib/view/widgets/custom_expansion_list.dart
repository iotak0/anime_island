
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/theme.dart';

class ExpansionList extends StatelessWidget {
  const ExpansionList({
    super.key,
    required this.children,
    required this.title,
  });
  final List<Widget> children;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        textColor: Color.fromARGB(255, 104, 208, 240),
        iconColor: Color.fromARGB(255, 104, 208, 240),
        title: Text(
          title,
          style: CustomTheme.darkTextTheme.displaySmall!,
        ),
        childrenPadding: const EdgeInsets.symmetric(vertical: 10),
        children: children);
  }
}
