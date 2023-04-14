import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getSharedPreferencesInstance() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
