import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final String title;
  final String content;

  const ExpandableContainer({
    super.key,
    required this.title,
    required this.content,
  });
  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        width: double.infinity,
        // height: _isExpanded ? 250 : 60,
        decoration: BoxDecoration(
          color: ColorUtility.grayExtraLight,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 8),
            trailing: _isExpanded
                ? const Icon(
                    Icons.keyboard_double_arrow_down,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.black,
                  ),
            title: Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.content,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
