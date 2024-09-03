import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static String? getProfileImageUrl() {
    final user = getCurrentUser();
    return user?.photoURL;
  }
}