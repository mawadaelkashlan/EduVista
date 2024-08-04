import 'package:edu_vista/utils/color_utility.dart';
import 'package:flutter/material.dart';

class DefaultElevatedbutton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const DefaultElevatedbutton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorUtility.primaryColor),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ))
        ],
      ),
    );
  }
}
