// importing required libary
import 'package:shared_preferences/shared_preferences.dart';

// creating SharePrefs Class
class SharedPrefs {
  // storing user data
  storeUser(user) async {
    // Obtain shared preferences.
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('user', user);
  }

  // retrieveing value
  getUser() async {
    // Obtain shared preferences.
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('user');
  }

  // removing user
  removeUser() async {
    // Obtain shared preferences.
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove('user');
  }
}
