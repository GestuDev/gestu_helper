part of '../gestu_helper.dart';

class MySharedPreferences {
  late final SharedPreferences _pref;
  static MySharedPreferences? _instance;
  MySharedPreferences._();

  static MySharedPreferences get i => MySharedPreferences.initialize();
  factory MySharedPreferences.initialize() {
    if (_instance == null) {
      _instance = MySharedPreferences._();
      _instance!._initializePref();
    }
    return _instance!;
  }

  Future<void> _initializePref() async {
    _pref = await SharedPreferences.getInstance();
  }

  static dynamic getObjectForKey(String key) {
    return i._pref.get(key);
  }

  static bool getBoolForKey(String key) {
    return i._pref.getBool(key) ?? false;
  }

  static void saveString({required String key, required String string}) {
    i._pref.setString(key, string);
  }

  static void saveBool({required String key, required dynamic value}) {
    i._pref.setBool(key, value);
  }

  static void removeObjectForKey(String key) {
    i._pref.remove(key);
  }

  static String get deviceUID {
    String? deviceUID = getObjectForKey('deviceUID');
    if (deviceUID == null) {
      deviceUID = GestuTools.getRandString(20);
      saveString(key: 'deviceUID', string: deviceUID);
    }
    return deviceUID;
  }
}
