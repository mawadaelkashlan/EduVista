import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevatedButtonRounded extends StatelessWidget {
  void Function()? onPressed;
  Color backgroundColor;
  Widget? icon;

  ElevatedButtonRounded(
      {required this.onPressed,
      required this.icon,
      required this.backgroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide.none,
        minimumSize: Size(60, 60),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: CircleBorder(), 
        padding: EdgeInsets.all(10),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
