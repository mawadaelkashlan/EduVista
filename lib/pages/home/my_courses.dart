import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text('Courses'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
    );
  }
}
