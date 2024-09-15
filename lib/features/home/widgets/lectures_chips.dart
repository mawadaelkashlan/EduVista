import 'package:edu_vista/utils/app_enums.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class LectureChipsWidget extends StatefulWidget {
  final CourseOptions? selectedOption;
  final void Function(CourseOptions) onChanged;

  const LectureChipsWidget({
    this.selectedOption,
    required this.onChanged,
    super.key,
  });

  @override
  State<LectureChipsWidget> createState() => _LectureChipsWidgetState();
}

class _LectureChipsWidgetState extends State<LectureChipsWidget> {
  late CourseOptions selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption ?? CourseOptions.Lectures;
  }

  final List<CourseOptions> chips = [
    CourseOptions.Lectures,
    CourseOptions.Download,
    CourseOptions.Certificate,
    CourseOptions.More,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedOption = chips[index];
              });
              widget.onChanged(chips[index]);
            },
            child: _ChipWidget(
              isSelected: chips[index] == selectedOption,
              label: chips[index].name,
            ),
          );
        },
        separatorBuilder: (ctx, index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}

class _ChipWidget extends StatelessWidget {
  final bool isSelected;
  final String label;

  const _ChipWidget({
    required this.isSelected,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(8),
      side: BorderSide.none,
      shape: const StadiumBorder(),
      backgroundColor:
          isSelected ? ColorUtility.deepYellow : ColorUtility.grayExtraLight,
      label: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.black, fontSize: 17),
      ),
    );
  }
}
