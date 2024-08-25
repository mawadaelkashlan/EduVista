import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/pages/home/course_detail_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoursesWidget extends StatefulWidget {
  final String rankValue;
  const CoursesWidget({
    required this.rankValue,
    super.key,
  });

  @override
  State<CoursesWidget> createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;

  @override
  void initState() {
    futureCall = FirebaseFirestore.instance
        .collection('courses')
        .where('rank', isEqualTo: widget.rankValue)
        .orderBy('created_date', descending: true)
        .get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCall,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error occurred'),
          );
        }

        if (!snapshot.hasData || (snapshot.data?.docs.isEmpty ?? false)) {
          return const Center(
            child: Text('No courses found'),
          );
        }

        var courses = List<Course>.from(snapshot.data?.docs
                .map((e) => Course.fromJson({'id': e.id, ...e.data()}))
                .toList() ??
            []);

        return SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: courses.length,
            itemBuilder: (BuildContext context, int index) {
              if (courses[index].image == null ||
                  courses[index].title == null ||
                  courses[index].rating == null) {
                return const SizedBox.shrink();
              }

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CourseDetailsPage.id,
                      arguments: courses[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 100,
                          child: Image(
                            image: NetworkImage(courses[index].image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("${courses[index].rating}",
                              style: const TextStyle(
                                  color: ColorUtility.gray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: courses[index].rating!,
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
                      Text(courses[index].title!,
                          style: const TextStyle(
                              color: ColorUtility.courseName,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          SvgPicture.asset(ImageUtility.instructor),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(courses[index].instructor!.name!,
                              style: const TextStyle(
                                  color: ColorUtility.courseName,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Text("\$ ${courses[index].price}",
                          style: const TextStyle(
                              color: ColorUtility.main,
                              fontSize: 14,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
