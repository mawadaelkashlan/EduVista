
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/widgets/course_detail_widgets/course_options.dart';
import 'package:edu_vista/widgets/course_detail_widgets/expandal_container.dart';
import 'package:flutter/material.dart';

class MoreOptionWidget extends StatelessWidget {
  const MoreOptionWidget({
    super.key,
    required this.widget,
  });

  final CourseOptionsWidgets widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('courses')
              .doc(widget.course.id!)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Error loading instructor information');
            }
            if (!snapshot.hasData || snapshot.data?.data() == null) {
              return const Text('No instructor information found');
            }
            final instructorDescription =
                snapshot.data!.data()!['instructor']['description'] ??
                    'No description available';
            return ExpandableContainer(
              title: 'About Instructor',
              content: instructorDescription,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const ExpandableContainer(
          title: 'Course Resources',
          content: '',
        ),
        const SizedBox(
          height: 10,
        ),
        const ExpandableContainer(
          title: 'Share this Course',
          content: '',
        ),
      ],
    );
  }
}
