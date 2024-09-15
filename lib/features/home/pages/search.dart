import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/features/home/widgets/recommend_categories.dart';
import 'package:edu_vista/features/home/widgets/recommend_courses.dart';
import 'package:edu_vista/widgets/label_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const LabelWidget(name: 'Trending'),
              RecommendedCategoriesWidget(future: getWatchedCategories()),
              const SizedBox(
                height: 20,
              ),
              const LabelWidget(name: 'Based On your Search'),
              RecommendedCoursesWidget(future: getRecommendedCourses()),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> getWatchedCategories() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('watchedCourses')
          .doc(user.uid)
          .collection('courses')
          .get();

      List<String> categories = [];
      for (var doc in snapshot.docs) {
        if (doc['category'] != null && !categories.contains(doc['category'])) {
          categories.add(doc['category']);
        }
      }
      return categories;
    }

    return [];
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getRecommendedCourses() async {
    List<String> watchedCategories = await getWatchedCategories();

    if (watchedCategories.isEmpty) {
      return [];
    }

    QuerySnapshot coursesSnapshot = await FirebaseFirestore.instance
        .collection('watchedCourses')
        .where('category', whereIn: watchedCategories)
        .limit(10)
        .get();

    return coursesSnapshot.docs;
  }
}
