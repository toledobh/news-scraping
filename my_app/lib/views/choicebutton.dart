//this is used for the true and false buttons
import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final Color color;
  final String text1;
  final IconData icon;
  final String text2;

  const ChoiceButton({
    Key? key,
    required this.color,
    required this.text1,
    required this.icon,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 70,
        height: 60,
        child: Row(
          children: [
            Text(text1),
            Icon(
              icon,
              color: color,
            ),
            Text(text2),
          ],
        ));
  }
}
