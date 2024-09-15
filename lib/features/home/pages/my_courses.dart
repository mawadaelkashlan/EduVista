import 'package:edu_vista/features/shopping_cart/cart_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/courses_widget.dart';
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
      body: const CoursesWidget(
        rankValue: 'top rated',
      ),
    );
  }
}
