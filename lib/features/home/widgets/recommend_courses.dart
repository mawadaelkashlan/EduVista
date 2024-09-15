import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecommendedCoursesWidget extends StatelessWidget {
  final Future<List<QueryDocumentSnapshot<Object?>>> future;

  const RecommendedCoursesWidget({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recommendations available.'));
        }

        var recommendedCourses = snapshot.data!;

        return SizedBox(
          height: 40,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: recommendedCourses.length,
            itemBuilder: (context, index) {
              var courseData =
                  recommendedCourses[index].data() as Map<String, dynamic>;

              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xffE0E0E0),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(courseData['courseName'] ??
                      'No Name'), // Adjust field as needed
                ),
              );
            },
          ),
        );
      },
    );
  }
}
