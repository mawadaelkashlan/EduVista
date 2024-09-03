import 'package:edu_vista/pages/auth/login.dart';
import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/arrowed_container.dart';
import 'package:edu_vista/widgets/profile/profile_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        currentUser = user;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.gbScaffold,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ProfileImage(
              downloadUrl: currentUser?.photoURL, 
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              currentUser?.displayName ?? 'Guest User',
              style: const TextStyle(
                  fontSize: 24,
                  color: ColorUtility.blueBlack,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Center(
            child: Text(
              currentUser?.email ?? 'guest@example.com',
              style: const TextStyle(
                  fontSize: 14,
                  color: ColorUtility.darkGrey,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ArrowedContainer(
            text: 'Edit',
            onTap: () {},
          ),
          ArrowedContainer(
            text: 'Setting',
            onTap: () {},
          ),
          ArrowedContainer(
            text: 'Achievements',
            onTap: () {},
          ),
          ArrowedContainer(
            text: 'About Us',
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginPage.id);
                } catch (e) {
                  print('Logout error: $e');
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: ColorUtility.darkRed, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
