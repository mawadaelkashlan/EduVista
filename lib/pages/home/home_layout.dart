import 'package:edu_vista/pages/home/home_page.dart';
import 'package:edu_vista/pages/home/my_courses.dart';
import 'package:edu_vista/pages/profile/profile_page.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LayoutPage extends StatefulWidget {
  static const String id = 'layout';
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> screens = [
    const HomePage(),
    const MyCourses(),
    const HomePage(),
    const HomePage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(children: screens),
        bottomNavigationBar: TabBar(
          indicator: const UnderlineTabIndicator(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            borderSide: BorderSide(
              color: ColorUtility.deepYellow,
              width: 5,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: ColorUtility.deepYellow,
          unselectedLabelColor: ColorUtility.gray,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            _buildTab(ImageUtility.home, 0),
            _buildTab(ImageUtility.book, 1),
            _buildTab(ImageUtility.search, 2),
            _buildTab(ImageUtility.message, 3),
            _buildTab(ImageUtility.person, 4),
          ],
        ),
      ),
    );
  }

  Tab _buildTab(String path, int index) {
    return Tab(
      iconMargin: const EdgeInsets.symmetric(vertical: 10),
      icon: SvgPicture.asset(
        path,
        color: _selectedIndex == index ? ColorUtility.deepYellow : Colors.black,
      ),
    );
  }
}
