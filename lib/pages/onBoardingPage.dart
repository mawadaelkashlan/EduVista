import 'package:edu_vista/pages/login.dart';
import 'package:edu_vista/utils/color_utility.dart';
import 'package:edu_vista/utils/images_utility.dart';
import 'package:edu_vista/widgets/slider_item.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  late final List<ItemSlider> _list = _getSliderData();
  int currentIndex = 0;
  bool isLast = false;

  List<ItemSlider> _getSliderData() => [
        const ItemSlider(
          image: ImagesUtility.onBoarding1,
          title: 'Certification and Badges',
          subTitle: 'Earn a certificate after completion of every course',
        ),
        const ItemSlider(
          image: ImagesUtility.onBoarding2,
          title: 'Progress Tracking',
          subTitle: 'Check your Progress of every course',
        ),
        const ItemSlider(
          image: ImagesUtility.onBoarding3,
          title: 'Offline Access',
          subTitle: 'Make your course available offline',
        ),
        const ItemSlider(
          image: ImagesUtility.onBoarding4,
          title: 'Course Catalog',
          subTitle: 'View in which courses you are enrolled',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Padding(
              padding: EdgeInsetsDirectional.only(end: 20),
              child: Text('Skip',
                  style: TextStyle(color: ColorUtility.secondaryColor)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: _list.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                  if (index == _list.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => ItemSlider(
                  image: _list[index].image,
                  title: _list[index].title,
                  subTitle: _list[index].subTitle,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      effect: const ExpandingDotsEffect(
                        dotColor: ColorUtility.secondaryColor,
                        activeDotColor: ColorUtility.primaryColor,
                        dotHeight: 7,
                        dotWidth: 24,
                        expansionFactor: 2,
                        spacing: 6,
                      ),
                      count: _list.length,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Row(
                        children: [
                          currentIndex > 0
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 40,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _pageController.previousPage(
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                      );
                                    },
                                    child: Container(
                                      height: 56,
                                      width: 56,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 4,
                                          )),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 40,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (isLast) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                }
                                _pageController.nextPage(
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                              child: Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorUtility.primaryColor,
                                  border: Border.all(
                                    color: ColorUtility.primaryColor,
                                    width: 4,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
