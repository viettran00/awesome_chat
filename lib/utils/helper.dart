import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUsernameKey = "USERNAME";
  static String sharedPreferenceUserEmailKey = "USEREMAIL";

  // saving data to shared preferences
  static Future<bool> saveUserLoggedInSharedPreferences(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUsernameSharedPreferences(String username) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(sharedPreferenceUsernameKey, username);
  }

  static Future<bool> saveUserEmailSharedPreferences(String email) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(sharedPreferenceUserEmailKey, email);
  }

  // fetching data from shared preferences
  static Future<bool> getUserLoggedInSharedPreferences() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceUserLoggedInKey) ?? false;
  }

  static Future<String?> getUsername() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUsernameKey);
  }

  static Future<String?> getUserEmail() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserEmailKey);
  }
}