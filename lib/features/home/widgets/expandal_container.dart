import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final String title;
  final String? content;
  final Widget? contentWidget;

  const ExpandableContainer({
    super.key,
    required this.title,
    this.content,
    this.contentWidget,
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
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.white : ColorUtility.grayExtraLight,
          borderRadius: BorderRadius.circular(6),
          border: _isExpanded
              ? Border.all(
                  color: ColorUtility
                      .deepYellow, 
                  width: 2.0, 
                )
              : Border.all(
                  color: Colors.transparent, 
                ),
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
                    color: ColorUtility.deepYellow,
                  )
                : const Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.black,
                  ),
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                color: _isExpanded ? ColorUtility.deepYellow : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            children: <Widget>[
              widget.contentWidget ?? const SizedBox.shrink(),
              widget.contentWidget == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.content ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
