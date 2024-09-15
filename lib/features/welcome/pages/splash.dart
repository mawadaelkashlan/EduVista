import 'package:edu_vista/features/auth/pages/login.dart';
import 'package:edu_vista/features/home/pages/home_layout.dart';
import 'package:edu_vista/features/welcome/pages/onBoardingPage.dart';
import 'package:edu_vista/services/pref_service.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  static String id = 'SplashPage';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(width: 250, child: SvgPicture.asset(ImageUtility.logo)),
      ),
    );
  }

  void _startApp() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      if (PreferencesService.isOnBoardingSeen) {
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushReplacementNamed(context, LayoutPage.id);
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.id);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingPage.id);
      }
    }
  }
}
