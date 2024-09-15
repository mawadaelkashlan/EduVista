import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/features/home/widgets/course_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DownloadedLectures extends StatelessWidget {
  const DownloadedLectures({
    super.key,
    required this.widget,
  });

  final CourseOptionsWidgets widget;

  @override
  Widget build(BuildContext context) {
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
  }
}
