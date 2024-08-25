import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/app_enums.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseOptionsWidgets extends StatefulWidget {
  final CourseOptions courseOption;
  final Course course;
  final void Function(Lecture) onLectureChosen;
  const CourseOptionsWidgets(
      {required this.courseOption,
      required this.course,
      required this.onLectureChosen,
      super.key});

  @override
  State<CourseOptionsWidgets> createState() => _CourseOptionsWidgetsState();
}

class _CourseOptionsWidgetsState extends State<CourseOptionsWidgets> {
  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.Lectures:
        return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('courses')
                .doc(widget.course.id)
                .collection('lectures')
                .get(),
            builder: (ctx, snapshot) {
              print('course Id ${widget.course.id}');
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
                  child: Text('No Lectures found'),
                );
              }
              var lectures = List<Lecture>.from(snapshot.data?.docs
                      .map((e) => Lecture.fromJson({'id': e.id, ...e.data()}))
                      .toList() ??
                  []);

              return GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(lectures.length, (index) {
                  return InkWell(
                    onTap: () => widget.onLectureChosen(lectures[index]),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorUtility.deepYellow,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 65,
                                    child: Text(
                                      lectures[index].title ?? 'No title',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                        SvgPicture.asset(ImageUtility.download),
                                  ),
                                ],
                              ),
                              Text(
                                lectures[index].describtion ?? 'No description',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${(lectures[index].duration! / 60).round()} min',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(ImageUtility.play),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            });

      case CourseOptions.Download:
        return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('courses')
                .doc(widget.course.id)
                .collection('lectures')
                .get(),
            builder: (ctx, snapshot) {
              print('course Id ${widget.course.id}');
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
                  child: Text('No Lectures found'),
                );
              }
              var lectures = List<Lecture>.from(snapshot.data?.docs
                      .map((e) => Lecture.fromJson({'id': e.id, ...e.data()}))
                      .toList() ??
                  []);

              return GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(lectures.length, (index) {
                  return InkWell(
                    onTap: () => widget.onLectureChosen(lectures[index]),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorUtility.deepYellow,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 65,
                                    child: Text(
                                      lectures[index].title ?? 'No title',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.done_all,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Text(
                                lectures[index].describtion ?? 'No description',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${(lectures[index].duration! / 60).round()} min',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(ImageUtility.play),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            });

      case CourseOptions.Certificate:
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              content: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Certificate of Completion',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'This Certifies that',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorUtility.certificateWord),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Muhammad Rafey',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorUtility.main),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Has Successfully Completed the Wallace Training Program, Entitled.',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorUtility.certificateWord),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Flutter course',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Issued on November 24, 2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorUtility.certificateWord),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ID: SK24568086',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Calvin E. McGinnis',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: ColorUtility.main),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Virginia M. Patterson',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: ColorUtility.deepYellow),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Virginia M. Patterson',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorUtility.certificateBlue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Issued on November 24, 2022',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorUtility.certificateWord),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
        return const SizedBox.shrink();

      case CourseOptions.More:
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: ColorUtility.grayLight,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: ColorUtility.grayLight,
                width: 2.0,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'About Instructor',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(
                    Icons.double_arrow,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
        );
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}
