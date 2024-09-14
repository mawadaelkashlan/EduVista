import 'package:edu_vista/pages/categories/categories_page.dart';
import 'package:edu_vista/pages/shopping_cart/cart_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/categories_widget.dart';
import 'package:edu_vista/widgets/courses_widget.dart';
import 'package:edu_vista/widgets/label_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: Text(
            'Welcome Back! ${FirebaseAuth.instance.currentUser?.displayName}'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ShoppingCart.id);
              }, icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelWidget(
                  name: 'Categories',
                  onSeeAllClicked: () {
                    Navigator.pushNamed(context, CategoriesPage.id);
                  },
                ),
                const CategoriesWidget(),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Rated Courses',
                  onSeeAllClicked: () {},
                ),
                const CoursesWidget(
                  rankValue: 'top rated',
                ),
                const SizedBox(
                  height: 20,
                ),
                LabelWidget(
                  name: 'Top Seller Courses',
                  onSeeAllClicked: () {},
                ),
                const CoursesWidget(
                  rankValue: 'top seller',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
