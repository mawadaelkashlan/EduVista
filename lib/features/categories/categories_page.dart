import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/features/home/widgets/expandal_container.dart';
import 'package:edu_vista/widgets/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesPage extends StatefulWidget {
  static const String id = 'categories';
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<QueryDocumentSnapshot>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  Future<List<QueryDocumentSnapshot>> fetchCategories() async {
    var categoriesSnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    return categoriesSnapshot.docs;
  }

  Future<List<QueryDocumentSnapshot>> fetchCoursesByCategory(
      String categoryName) async {
    var coursesSnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .where('category.name', isEqualTo: categoryName)
        .get();
    return coursesSnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: 'Categories',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, right: 10, left: 10),
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No categories found.'));
            } else {
              var categories = snapshot.data!;
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  var category = categories[index];
                  String categoryName = category['name'];

                  return FutureBuilder<List<QueryDocumentSnapshot>>(
                    future: fetchCoursesByCategory(categoryName),
                    builder: (context, courseSnapshot) {
                      if (courseSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (courseSnapshot.hasError) {
                        return Text('Error: ${courseSnapshot.error}');
                      } else {
                        var courses = courseSnapshot.data ?? [];
                        return ExpandableContainer(
                          title: categoryName,
                          contentWidget: CourseListWidget(courses: courses),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 15),
                itemCount: categories.length,
              );
            }
          },
        ),
      ),
    );
  }
}

class CourseListWidget extends StatelessWidget {
  final List<QueryDocumentSnapshot> courses;

  const CourseListWidget({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'No courses found.',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          var courseData = courses[index].data() as Map<String, dynamic>;
          String? imageUrl = courseData['image'] as String?;
          String? title = courseData['title'] as String?;
          double? rating = courseData['rating']?.toDouble();
          String? instructorName = courseData['instructor']?['name'] as String?;
          double? price = courseData['price']?.toDouble();
          if (imageUrl == null || title == null || rating == null) {
            return const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   CourseDetailsPage.id,
              //   arguments: courses[index],
              // );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 100,
                      child: Image(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "$rating",
                        style: const TextStyle(
                          color: ColorUtility.gray,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: rating,
                        glowColor: ColorUtility.main,
                        unratedColor: ColorUtility.grayExtraLight,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: ColorUtility.main,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                    ],
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: ColorUtility.courseName,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageUtility.instructor),
                      const SizedBox(width: 5),
                      Text(
                        instructorName ?? '',
                        style: const TextStyle(
                          color: ColorUtility.courseName,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "\$ ${price?.toStringAsFixed(2) ?? 'N/A'}",
                    style: const TextStyle(
                      color: ColorUtility.main,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
