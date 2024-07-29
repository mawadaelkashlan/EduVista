import 'package:edu_vista/utils/color_utility.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.scaffoldBackgroundColor,
        title: Text(
          'Login',
        ),
        centerTitle: true,
      ),
    );
  }
}
