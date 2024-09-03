// import 'package:edu_vista/widgets/video_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_vista/blocs/course/course_bloc.dart';
import 'package:edu_vista/blocs/lecture/lecture_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/course_detail_widgets/lectures_chips.dart';
import 'package:edu_vista/widgets/course_detail_widgets/course_options.dart';

class CourseDetailsPage extends StatefulWidget {
  final Course course;
  static const String id = 'courseDetails';

  const CourseDetailsPage({super.key, required this.course});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    context.read<LectureBloc>().add(LectureEventInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Video part at the top
            //             BlocBuilder<LectureBloc, LectureState>(builder: (ctx, state) {
            //   var stateEx = state is LectureChosenState ? state : null;

            //   if (stateEx == null) {
            //     return const SizedBox.shrink();
            //   }

            //   return Container(
            //     height: 250,
            //     child: stateEx.lecture.lecture_url == null ||
            //             stateEx.lecture.lecture_url == ''
            //         ? const Center(
            //             child: Text(
            //             'Invalid Url',
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold),
            //           ))
            //         : VideoBoxWidget(
            //             url: stateEx.lecture.lecture_url ?? '',
            //             // url: stateEx.lecture.lecture_url ?? '',
            //           ),
            //   );
            // }),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.course.title ?? 'No title',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorUtility.courseName,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.course.instructor?.name ?? 'No Instructor Name',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorUtility.courseName,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const _BodyWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({super.key});

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (ctx, state) {
        return Column(
          children: [
            LectureChipsWidget(
              selectedOption: (state is CourseOptionStateChanges)
                  ? state.courseOption
                  : null,
              onChanged: (courseOption) {
                context
                    .read<CourseBloc>()
                    .add(CourseOptionChosenEvent(courseOption));
              },
            ),
            const SizedBox(height: 10),
            if (state is CourseOptionStateChanges)
              CourseOptionsWidgets(
                course: context.read<CourseBloc>().course!,
                courseOption: state.courseOption,
                onLectureChosen: (lecture) async {
                  final docRef = FirebaseFirestore.instance
                      .collection('course_user_progress')
                      .doc(FirebaseAuth.instance.currentUser!.uid);

                  final snapshot = await docRef.get();

                  if (snapshot.exists) {
                    try {
                      await docRef.update({
                        context.read<CourseBloc>().course!.id!:
                            FieldValue.increment(1),
                      });
                    } catch (e) {
                      print('Error updating document: $e');
                    }
                  } else {
                    try {
                      await docRef.set({
                        context.read<CourseBloc>().course!.id!: 1,
                      });
                    } catch (e) {
                      print('Error creating document: $e');
                    }
                  }

                  context.read<LectureBloc>().add(LectureChosenEvent(lecture));
                },
              )
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
