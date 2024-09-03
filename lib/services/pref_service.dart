import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  static SharedPreferences? prefs;

  // Initialize the SharedPreferences instance
  static Future<void> init() async {
    try {
      prefs = await SharedPreferences.getInstance();
      print('prefs is setup successfully');
    } catch (e) {
      print('Failed to initialize preferences: $e');
    }
  }

  // Getter and setter for the onboarding flag
  static bool get isOnBoardingSeen =>
      prefs?.getBool('isOnBoardingSeen') ?? false;

  static set isOnBoardingSeen(bool value) =>
      prefs?.setBool('isOnBoardingSeen', value);

  // Getter and setter for the download URL
  static String? get downloadUrl => prefs?.getString('profileImageUrl');

  static set downloadUrl(String? value) {
    if (value != null) {
      prefs?.setString('profileImageUrl', value);
    }
  }
}
