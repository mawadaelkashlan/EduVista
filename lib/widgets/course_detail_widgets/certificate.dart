
  import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

void showCertificate(BuildContext context) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Certificate of Completion',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'This Certifies that',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Muhammad Rafey',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.main),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Has Successfully Completed the Wallace Training Program, Entitled.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Flutter course',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Issued on November 24, 2022',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ID: SK24568086',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Calvin E. McGinnis',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ColorUtility.main),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Virginia M. Patterson',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ColorUtility.deepYellow),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Virginia M. Patterson',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.blueBlack),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Issued on November 24, 2022',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

