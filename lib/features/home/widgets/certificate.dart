
  import 'package:edu_vista/services/user_service.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:flutter/material.dart';

void showCertificate(BuildContext context) {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Certificate of Completion',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'This Certifies that',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  UserService.getCurrentUser()!.displayName ?? 'please login',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.main),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Has Successfully Completed the Wallace Training Program, Entitled.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Flutter course',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Issued on November 24, 2022',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.darkGrey),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'ID: SK24568086',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Calvin E. McGinnis',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ColorUtility.main),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Virginia M. Patterson',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: ColorUtility.deepYellow),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Virginia M. Patterson',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorUtility.blueBlack),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
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

