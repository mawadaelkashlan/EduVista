import 'package:edu_vista/features/home/pages/get_all_courses.dart';
import 'package:edu_vista/features/shopping_cart/cart_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text('All Courses'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ShoppingCart.id);
              },
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: AllCoursesWidget(),
      ),
    );
  }
}
