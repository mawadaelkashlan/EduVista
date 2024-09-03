import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ArrowedContainer extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const ArrowedContainer({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: ColorUtility.grayExtraLight,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: ColorUtility.grayExtraLight,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Icon(
                  Icons.double_arrow_rounded,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
