import 'dart:ui';
import 'package:edu_vista/features/auth/pages/login.dart';
import 'package:edu_vista/features/auth/pages/reset_pass.dart';
import 'package:edu_vista/features/auth/pages/sign_up.dart';
import 'package:edu_vista/features/categories/categories_page.dart';
import 'package:edu_vista/features/home/pages/course_detail_page.dart';
import 'package:edu_vista/features/home/pages/home_layout.dart';
import 'package:edu_vista/features/home/pages/home_page.dart';
import 'package:edu_vista/features/shopping_cart/cart_page.dart';
import 'package:edu_vista/features/welcome/pages/onBoardingPage.dart';
import 'package:edu_vista/features/welcome/pages/splash.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class EduVista extends StatelessWidget {
  const EduVista({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: _CustomScrollBehaviour(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorUtility.gbScaffold,
        fontFamily: ' PlusJakartaSans',
        colorScheme: ColorScheme.fromSeed(seedColor: ColorUtility.main),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final String routeName = settings.name ?? '';
        final dynamic data = settings.arguments;
        switch (routeName) {
          case LayoutPage.id:
            return MaterialPageRoute(builder: (context) => const LayoutPage());
          case LoginPage.id:
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case SignUpPage.id:
            return MaterialPageRoute(builder: (context) => const SignUpPage());
          case ResetPasswordPage.id:
            return MaterialPageRoute(
                builder: (context) => const ResetPasswordPage());
          case OnBoardingPage.id:
            return MaterialPageRoute(
                builder: (context) => const OnBoardingPage());
          case HomePage.id:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case CourseDetailsPage.id:
            return MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                      course: data,
                    ));
          case CategoriesPage.id:
            return MaterialPageRoute(
                builder: (context) => const CategoriesPage());
          case ShoppingCart.id:
            return MaterialPageRoute(
                builder: (context) => const ShoppingCart());
          default:
            return MaterialPageRoute(builder: (context) => const SplashPage());
        }
      },
      initialRoute: SplashPage.id,
    );
  }
}

class _CustomScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
