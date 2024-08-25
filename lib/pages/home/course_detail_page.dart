import 'package:edu_vista/blocs/course/course_bloc.dart';
import 'package:edu_vista/blocs/lecture/lecture_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/widgets/course_options.dart';
import 'package:edu_vista/widgets/lectures_chips.dart';
import 'package:flutter/material.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_box/video_box.dart';


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
    context.read<CourseBloc>().add(CourseFetchEvent(widget.course));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<LectureBloc, LectureState>(builder: (ctx, state) {
          var stateEx = state is LectureChosenState ? state : null;
          return SizedBox(
            height: 250,
            child: VideoBox(
              controller: VideoController(
                  source: VideoPlayerController.networkUrl(
                      Uri.parse(stateEx!.lecture.lecture_url!))),
            ),
          );
        }),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: BlocBuilder<CourseBloc, CourseState>(
                builder: (context, state) {
                  return Container(
                    height: 600,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.course.title!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: ColorUtility.courseName,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(widget.course.instructor!.name!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ColorUtility.courseName,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: BlocBuilder<CourseBloc, CourseState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    LectureChipsWidget(
                                      selectedOption:
                                          (state is CourseOptionStateChanges)
                                              ? state.courseOption
                                              : null,
                                      onChanged: (courseOption) {
                                        context.read<CourseBloc>().add(
                                            CourseOptionChosenEvent(
                                                courseOption));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    (state is CourseOptionStateChanges)
                                        ? CourseOptionsWidgets(
                                            course: context
                                                .read<CourseBloc>()
                                                .course!,
                                            courseOption: state.courseOption,
                                            onLectureChosen: (lecture) {
                                              context.read<CourseBloc>().add(
                                                  LectureChosenEvent(lecture) as CourseEvent);
                                            },
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
