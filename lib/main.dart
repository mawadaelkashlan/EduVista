import 'package:edu_vista/pages/splash.dart';
import 'package:edu_vista/utils/color_utility.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtility.scaffoldBackgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
