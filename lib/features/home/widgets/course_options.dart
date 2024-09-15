import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/features/home/blocs/course/course_bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/app_enums.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/features/home/widgets/certificate.dart';
import 'package:edu_vista/features/home/widgets/downloaded_lectures_widget.dart';
import 'package:edu_vista/features/home/widgets/more_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late Future<QuerySnapshot<Map<String, dynamic>>> futureCall;
  List<Lecture>? lectures;
  bool isLoading = false;
  Lecture? selectedLecture;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1200), () async {});
    if (!mounted) return;
    lectures = await context.read<CourseBloc>().getLectures();
    if (lectures!.isNotEmpty) {
      widget.onLectureChosen(lectures![0]);
      selectedLecture = lectures![0];
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.courseOption) {
      case CourseOptions.Lectures:
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (lectures == null || (lectures!.isEmpty)) {
          return const Center(
            child: Text('No lectures found'),
          );
        } else {
          return GridView.count(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(lectures!.length, (index) {
              return InkWell(
                onTap: () {
                  widget.onLectureChosen(lectures![index]);
                  selectedLecture = lectures![index];
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selectedLecture!.id == lectures![index].id
                        ? ColorUtility.deepYellow
                        : const Color(0xffE0E0E0),
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
                                  lectures![index].title ?? 'No title',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: selectedLecture!.id ==
                                              lectures![index].id
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(ImageUtility.download),
                              ),
                            ],
                          ),
                          Text(
                            lectures![index].describtion ?? 'No description',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    selectedLecture!.id == lectures![index].id
                                        ? Colors.white
                                        : Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                '${(lectures![index].duration! / 60).round()} min',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: selectedLecture!.id ==
                                            lectures![index].id
                                        ? Colors.white
                                        : Colors.black),
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
        }

      case CourseOptions.Download:
        return DownloadedLectures(widget: widget);

      case CourseOptions.Certificate:
        showCertificate(context);
        return const SizedBox.shrink();

      case CourseOptions.More:
        return MoreOptionWidget(widget: widget);
      default:
        return Text('Invalid option ${widget.courseOption.name}');
    }
  }
}
